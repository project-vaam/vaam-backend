package projeto.algorithms_process_mining.inductive_miner;

import gnu.trove.iterator.TIntIterator;
import gnu.trove.map.TIntObjectMap;
import gnu.trove.set.TIntSet;
import org.deckfour.xes.classification.XEventClass;
import org.deckfour.xes.classification.XEventClasses;
import org.deckfour.xes.classification.XEventClassifier;
import org.deckfour.xes.info.XLogInfo;
import org.deckfour.xes.info.XLogInfoFactory;
import org.deckfour.xes.info.impl.XLogInfoImpl;
import org.deckfour.xes.model.*;
import org.processmining.directlyfollowsmodelminer.mining.DFMMiner;
import org.processmining.directlyfollowsmodelminer.mining.DFMMiningParameters;
import org.processmining.directlyfollowsmodelminer.mining.DFMMiningParametersAbstract;
import org.processmining.directlyfollowsmodelminer.model.DirectlyFollowsModel;
import org.processmining.framework.plugin.ProMCanceller;
import org.processmining.plugins.InductiveMiner.MultiSet;
import org.processmining.plugins.InductiveMiner.Pair;
import org.processmining.plugins.InductiveMiner.Triple;
import org.processmining.plugins.InductiveMiner.dfgOnly.log2logInfo.IMLog2IMLogInfoDefault;
import org.processmining.plugins.InductiveMiner.mining.IMLogInfo;
import org.processmining.plugins.InductiveMiner.mining.logs.LifeCycleClassifier;
import org.processmining.plugins.graphviz.colourMaps.ColourMapBlue;
import org.processmining.plugins.graphviz.dot.Dot;
import org.processmining.plugins.inductiveVisualMiner.InductiveVisualMinerState;
import org.processmining.plugins.inductiveVisualMiner.alignedLogVisualisation.data.AlignedLogVisualisationData;
import org.processmining.plugins.inductiveVisualMiner.alignedLogVisualisation.data.AlignedLogVisualisationDataImplEmpty;
import org.processmining.plugins.inductiveVisualMiner.alignedLogVisualisation.data.AlignedLogVisualisationDataImplFrequencies;
import org.processmining.plugins.inductiveVisualMiner.alignment.*;
import org.processmining.plugins.inductiveVisualMiner.animation.ComputeAnimation;
import org.processmining.plugins.inductiveVisualMiner.animation.DotToken;
import org.processmining.plugins.inductiveVisualMiner.animation.IvMTrace2dotToken2;
import org.processmining.plugins.inductiveVisualMiner.animation.Scaler;
import org.processmining.plugins.inductiveVisualMiner.chain.IvMCanceller;
import org.processmining.plugins.inductiveVisualMiner.export.ExportAlignment;
import org.processmining.plugins.inductiveVisualMiner.export.XDFMExtension;
import org.processmining.plugins.inductiveVisualMiner.export.XModelAlignmentExtension;
import org.processmining.plugins.inductiveVisualMiner.helperClasses.IteratorWithPosition;
import org.processmining.plugins.inductiveVisualMiner.helperClasses.IvMModel;
import org.processmining.plugins.inductiveVisualMiner.helperClasses.ShortestPathGraph;
import org.processmining.plugins.inductiveVisualMiner.helperClasses.sizeMaps.SizeMapLinear;
import org.processmining.plugins.inductiveVisualMiner.ivmlog.*;
import org.processmining.plugins.inductiveVisualMiner.logFiltering.FilterLeastOccurringActivities;
import org.processmining.plugins.inductiveVisualMiner.mode.ModePaths;
import org.processmining.plugins.inductiveVisualMiner.mode.ModePathsDeviations;
import org.processmining.plugins.inductiveVisualMiner.performance.*;
import org.processmining.plugins.inductiveVisualMiner.traceview.TraceViewEventColourMap;
import org.processmining.plugins.inductiveVisualMiner.visualMinerWrapper.VisualMinerParameters;
import org.processmining.plugins.inductiveVisualMiner.visualMinerWrapper.miners.DfgMiner;
import org.processmining.plugins.InductiveMiner.mining.logs.IMLog;
import org.processmining.plugins.InductiveMiner.mining.logs.IMLogImpl;
import org.processmining.plugins.inductiveVisualMiner.visualisation.*;
import projeto.algorithms_process_mining.FootprintMatrix;
import projeto.algorithms_process_mining.FootprintStatistics;
import projeto.core.Event;
import projeto.data.XESHelper;
import java.util.*;

public class FootprintInductive extends FootprintMatrix {

    private InductiveMiner inductiveMiner;

    //private DirectlyFollowsGraph dfg;
    private IvMHelper ivm;

    public FootprintInductive(InductiveMiner algorithm, List<Event> events, LinkedHashSet<String> eventNames, boolean statistics) {
        super(algorithm, eventNames, statistics);
        this.inductiveMiner = algorithm;

        Pair<IvMLogInfo,IvMModel> x = alignLog(getEventLog(events));
        this.ivm = getDFM(x.getA(), x.getB(), true); //Por enquanto true

        super.eventNames = new LinkedHashSet<>(Arrays.asList(ivm.getActivitiesComFreq()));
        super.eventNamesMapper = buildEventsMapper(super.eventNames);
        //Get start and end activities from dfg
        for (Integer startActivity : ivm.getModel().getDfg().getStartNodes().toArray()) {
            super.startEvents.put(startActivity,(int) 1);//Hardcoded 1. Não sei que valor meter aqui.
        }
        for (Integer endActivity : ivm.getModel().getDfg().getEndNodes().toArray()) {
            super.endEvents.put(endActivity,(int) 1);
        }
        //obrigar novo
        super.footprintStatistics = new FootprintStatistics(this);
        footprintStatistics.setFrequencyFromIvMHelper(ivm);
    }

    public static Map<String, Integer> buildEventsMapper( Set<String> eventNames )
    {
        Map<String, Integer> eventNamesMapper = new HashMap<>();
        int index = 0;
        for (String s : eventNames)
            eventNamesMapper.put(s, index++);

        return eventNamesMapper;
    }

    private XLog getEventLog(List<Event> events){
        String csvContent = XESHelper.eventsToCsv(events);//converter para csv
        XLog log = XESHelper.eventsCsvToXes(csvContent);//Converter para xes
        return log;
    }

    private Pair<IvMLogInfo,IvMModel> alignLog(XLog log){
        ProMCanceller proMCanceller = () -> false;
        IvMCanceller ivMCanceller = new IvMCanceller(proMCanceller);
        //IvMModel
        DfgMiner miner = new DfgMiner();
        IMLog imLog = new IMLogImpl(log,log.getClassifiers().get(0),miner.getLifeCycleClassifier());
        IMLogInfo imLogInfo = IMLog2IMLogInfoDefault.log2logInfo(imLog);

        //Filtrar por caminhos e actividades
        FilterLeastOccurringActivities.filter(imLog,imLogInfo, inductiveMiner.activities, null);
        VisualMinerParameters visualMinerParameters = new VisualMinerParameters(inductiveMiner.paths);
        IvMModel model = miner.mine(imLog,imLogInfo,visualMinerParameters,ivMCanceller);



        /*ALIGNMENT*/
        AlignmentComputerImpl alignmentComputer = new AlignmentComputerImpl();
        //porque levou com o filter das activities
        //XLog newLog = log3.toXLog(); //Porque foi aligned?
        // Align do IMLog para IvMLogNotFiltered

        XEventClassifier classifier = imLog.getClassifier();
        XEventPerformanceClassifier performanceClassifier = new XEventPerformanceClassifier(classifier);

        XEventClasses activityEventClasses = XLogInfoFactory.createLogInfo(log,classifier).getEventClasses();
        XEventClasses performanceEventClasses = XLogInfoFactory.createLogInfo(log, performanceClassifier).getEventClasses();

        IvMLogNotFiltered notFiltered;
        try {
            notFiltered = AlignmentPerformance.alignDfg(alignmentComputer,model,performanceClassifier,log,activityEventClasses,performanceEventClasses,proMCanceller);
        }catch (Exception e){
            System.out.println("Could not align log: "+e);
            return null;
        }
        if(notFiltered==null)
            return null;


        IvMLogInfo logInfo = new IvMLogInfo(notFiltered,model);

        return Pair.of(logInfo,model);
    }

    private IvMHelper getDFM(IvMLogInfo logInfo,IvMModel model,Boolean showDeviations){

        AlignedLogVisualisationDataImplFrequencies visualisationDataImplFrequencies = new AlignedLogVisualisationDataImplFrequencies(model,logInfo);

        DfmVisualisation dfmVisualisation = new DfmVisualisation();
        ProcessTreeVisualisationParameters dfmParameters = new ProcessTreeVisualisationParameters();
        if (showDeviations){
            dfmParameters.setShowFrequenciesOnModelEdges(true);
            dfmParameters.setShowFrequenciesOnMoveEdges(true);
        } else {
            dfmParameters.setShowFrequenciesOnModelEdges(true);
            dfmParameters.setShowFrequenciesOnMoveEdges(false);
            dfmParameters.setShowLogMoves(false);
            dfmParameters.setShowModelMoves(false);
        }

        Triple<Dot, ProcessTreeVisualisationInfo, TraceViewEventColourMap> triple = dfmVisualisation.fancy(model,visualisationDataImplFrequencies,dfmParameters);

        ProcessTreeVisualisationInfo ptVisualizationInfo = triple.getB();
        Set<LocalDotNode> allNodes = ptVisualizationInfo.getNodes();
        Set<LocalDotEdge> allEdges = ptVisualizationInfo.getEdges();
        //desvios?
        Set<LocalDotEdge> desvios = ptVisualizationInfo.getAllLogMoveEdges();
        //Todas - (desvios+startEdges+endEdges) (removidas mais à frente)
        Set<LocalDotEdge> normalEdges = new HashSet<>(allEdges);
        if (desvios.size()>0)
            normalEdges.removeIf(desvios::contains);

        Collection<LocalDotNode> activityNodes = ptVisualizationInfo.getAllActivityNodes();
        LocalDotNode sourceNode = ptVisualizationInfo.getSource();
        LocalDotNode sinkNode = ptVisualizationInfo.getSink();


        //Lista aux com id dos nodes + nome
        List<Integer> allModelNodesId = new LinkedList<>();
        List<String> allModelNodesName = new LinkedList<>();
        for (Integer node : model.getAllNodes()) {
            allModelNodesId.add(node);
            allModelNodesName.add(model.getActivityName(node));
        }

        //get startActivities and end
        List<Pair<Integer,Integer>> startActivities = new LinkedList<>();
        List<Pair<Integer,Integer>> endActivities = new LinkedList<>();
        for (LocalDotEdge edge : allEdges) {
            //Start activities
            if(edge.getSource() == sourceNode){
                LocalDotNode startActivity = edge.getTarget();
                int weight = -1;
                if (isInteger(edge.getLabel()))
                   weight = Integer.parseInt(edge.getLabel());
                //Se a node não existir no modelo quer dizer que é um nó vazio. Adicioná-lo à lista aux
                if (startActivity.getUnode()==-1){
                    String label = "empty-node#"+startActivity.getId();
                    int index = allModelNodesName.indexOf(label);
                    if(index==-1){ //não existe
                        index = allModelNodesId.size();
                        allModelNodesId.add(index);
                        allModelNodesName.add(label);
                        startActivities.add(Pair.of(index,weight));
                    }
                    else{
                        startActivities.add(Pair.of(index,weight));
                    }
                } else {
                    startActivities.add(Pair.of(startActivity.getUnode(),weight));
                }
                //Remover as edges start e end
                normalEdges.remove(edge);
            }
            //end activities
            if (edge.getTarget() == sinkNode){
                LocalDotNode endActivity = edge.getSource();
                int weight = -1;
                if (isInteger(edge.getLabel()))
                    weight = Integer.parseInt(edge.getLabel());
                if (endActivity.getUnode()==-1){
                    String label = "empty-node#"+endActivity.getId();
                    int index = allModelNodesName.indexOf(label);
                    if(index==-1){ //não existe
                        index = allModelNodesId.size();
                        allModelNodesId.add(index);
                        allModelNodesName.add(label);
                        endActivities.add(Pair.of(index,weight));
                    }
                    else{
                        endActivities.add(Pair.of(index,weight));
                    }
                } else {
                    endActivities.add(Pair.of(endActivity.getUnode(),weight));
                }
                //Remover as edges start e end
                normalEdges.remove(edge);
            }
        }

        HashMap<Pair<Integer,Integer>,Integer> edgeCardinality = new HashMap<>();
        HashMap<Pair<String,String>,Integer> edgeCardinalityByName = new HashMap<>();
        //edge cardinalities - as start e end
        for (LocalDotEdge edge : normalEdges) {
            LocalDotNode source = edge.getSource();
            LocalDotNode target = edge.getTarget();
            String sourceLabel = source.getLabel();
            String targetLabel = target.getLabel();
            int sourceIndex = source.getUnode();
            int targetIndex = target.getUnode();
            if (source.getUnode() == -1){ //Quer dizer que é um empty-node?
                sourceLabel = "empty-node#"+source.getId();
                int index = allModelNodesName.indexOf(sourceLabel);
                if (index!=-1){
                    index = allModelNodesId.size();
                    allModelNodesId.add(index);
                    allModelNodesName.add(sourceLabel);
                }
                sourceIndex = index;
            }
            if (target.getUnode() == -1){ //Quer dizer que é um empty-node?
                targetLabel = "empty-node#"+source.getId();
                int index = allModelNodesName.indexOf(targetLabel);
                if (index!=-1){
                    index = allModelNodesId.size();
                    allModelNodesId.add(index);
                    allModelNodesName.add(targetLabel);
                }
                targetIndex = index;
            }
            int weight = -1;
            if (isInteger(edge.getLabel()))
                weight = Integer.parseInt(edge.getLabel());
            edgeCardinality.put(Pair.of(sourceIndex,targetIndex),weight);
            edgeCardinalityByName.put(Pair.of(sourceLabel,targetLabel),weight);
        }

        //Contém os valores correspondentes no visual miner @Deprecated daqui para baixo
        HashMap<Integer,Long> nodeLabels = new HashMap<>();
        String[] activitiesComFreq = new String[model.getDfg().getAllNodeNames().length];
        for (int i = 0; i < model.getDfg().getAllNodeNames().length; i++) {
            String activityName = model.getActivityName(i);
            Long freq = visualisationDataImplFrequencies.getNodeLabel(i,true).getB();
            nodeLabels.put(i,freq);
            activitiesComFreq[i] = activityName+"@"+freq;
        }




        for (int i = 0; i < model.getDfg().getAllNodeNames().length; i++) {
            for (int j = 0; j < model.getDfg().getAllNodeNames().length; j++) {
                //Preencher os edges
                //Novo Par com source e node
                if (model.getDfg().containsEdge(i,j)){
                    Pair<String,Long> freq = visualisationDataImplFrequencies.getEdgeLabel(i,j,true);
                    edgeCardinality.put(Pair.of(i,j),freq.getRight().intValue());
                    edgeCardinalityByName.put(Pair.of(model.getActivityName(i),model.getActivityName(j)),freq.getRight().intValue());
                }
            }
        }

        IvMHelper ivMHelper = new IvMHelper();
        ivMHelper.setEdgeCardinality(edgeCardinality);
        ivMHelper.setModel(model);
        ivMHelper.setActivityCardinalitiesComplete(nodeLabels);
        ivMHelper.setActivitiesComFreq(activitiesComFreq);

        //IvMHelper ivMHelper = new IvMHelper();

        return ivMHelper;
    }

    //https://stackoverflow.com/questions/5439529/determine-if-a-string-is-an-integer-in-java
    public static boolean isInteger(String s) {
        try {
            Integer.parseInt(s);
        } catch(NumberFormatException e) {
            return false;
        } catch(NullPointerException e) {
            return false;
        }
        // only got here if we didn't return false
        return true;
    }


    //Faz algo relacionado com performance. Pode ser preciso
    public void performance(IvMModel model,IvMLogNotFiltered notFiltered){
        IvMLogFiltered filtered = new IvMLogFilteredImpl(notFiltered);
        IvMLogInfo logInfo = new IvMLogInfo(notFiltered,model);
        /*--NOVO--*/
        TIntObjectMap<QueueActivityLog> queueActivityLogs = QueueMineActivityLog.mine(model, filtered);
        QueueLengths method = new QueueLengthsImplCombination(queueActivityLogs);

        PerformanceWrapper performance = new PerformanceWrapper(method, queueActivityLogs,model.getMaxNumberOfNodes());
        PerformanceWrapperTraces resultTraces = new PerformanceWrapperTraces();


        //compute node times
        for (TIntIterator it = queueActivityLogs.keySet().iterator(); it.hasNext();) {
            int unode = it.next();
            QueueActivityLog activityLog = queueActivityLogs.get(unode);
            for (int i = 0; i < activityLog.size(); i++) {

                //waiting time
                if (activityLog.hasInitiate(i) && activityLog.hasStart(i)) {
                    long waiting = activityLog.getStart(i) - activityLog.getInitiate(i);
                    performance.addNodeValue(PerformanceWrapper.TypeNode.waiting, unode, waiting);
                    resultTraces.addValue(PerformanceWrapperTraces.Type.waiting, activityLog.getTraceIndex(i), waiting);
                }

                //queueing time
                if (activityLog.hasEnqueue(i) && activityLog.hasStart(i)) {
                    long queueing = activityLog.getStart(i) - activityLog.getEnqueue(i);
                    performance.addNodeValue(PerformanceWrapper.TypeNode.queueing, unode, queueing);
                    resultTraces.addValue(PerformanceWrapperTraces.Type.queueing, activityLog.getTraceIndex(i), queueing);
                }

                //service time
                if (activityLog.hasStart(i) && activityLog.hasComplete(i)) {
                    long service = activityLog.getComplete(i) - activityLog.getStart(i);
                    performance.addNodeValue(PerformanceWrapper.TypeNode.service, unode, service);
                    resultTraces.addValue(PerformanceWrapperTraces.Type.service, activityLog.getTraceIndex(i), service);
                }

                //sojourn time
                if (activityLog.hasInitiate(i) && activityLog.hasComplete(i)) {
                    long sojourn = activityLog.getComplete(i) - activityLog.getInitiate(i);
                    performance.addNodeValue(PerformanceWrapper.TypeNode.sojourn, unode, sojourn);

                    /**
                     * We could technically show trace sojourn time, but
                     * this would cause confusion with the trace duration.
                     */
                    //resultTraces.addValue(Type.sojourn, activityLog.getTraceIndex(i), sojourn);
                }

                //elapsed time
                if (activityLog.hasStartTrace(i) && activityLog.hasStart(i)) {
                    performance.addNodeValue(PerformanceWrapper.TypeNode.elapsed, unode,
                            activityLog.getStart(i) - activityLog.getStartTrace(i));
                } else if (activityLog.hasStartTrace(i) && activityLog.hasComplete(i)) {
                    performance.addNodeValue(PerformanceWrapper.TypeNode.elapsed, unode,
                            activityLog.getComplete(i) - activityLog.getStartTrace(i));
                }

                //remaining time
                if (activityLog.hasEndTrace(i) && activityLog.hasComplete(i)) {
                    performance.addNodeValue(PerformanceWrapper.TypeNode.remaining, unode,
                            activityLog.getEndTrace(i) - activityLog.getComplete(i));
                } else if (activityLog.hasEndTrace(i) && activityLog.hasStart(i)) {
                    performance.addNodeValue(PerformanceWrapper.TypeNode.remaining, unode,
                            activityLog.getEndTrace(i) - activityLog.getStart(i));
                }
            }
        }

        resultTraces.finalise(performance);

        //compute global times
        for (IteratorWithPosition<IvMTrace> it = filtered.iterator(); it.hasNext();) {
            IvMTrace trace = it.next();
            if (trace.getRealStartTime() != null && trace.getRealEndTime() != null) {
                performance.addGlobalValue(PerformanceWrapper.TypeGlobal.duration, trace.getRealEndTime() - trace.getRealStartTime());
            }
        }

        performance.finalise();
    }


    @Override
    public boolean areEventsConnected(int a, int b) {
        return ivm.getModel().getDfg().containsEdge(a,b);
    }
}
