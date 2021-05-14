/*EVENTS*/
SET IDENTITY_INSERT ncfinderdb.dbo.EVENTS ON;
insert INTO ncfinderdb.dbo.EVENTS ([id], [activityId], [processId], [mouldCode], [partCode], [startDate], [endDate], [duration], [isEstimatedEnd], [workstationId])
select 53,1, 3, '1', NULL, '2011-12-30 11:02:00.000000', '2011-12-31 10:06:00.000000',0, NULL, 1 UNION ALL
select 54,2, 3, '1', NULL, '2011-12-31 10:06:00.000000', '2012-01-05 15:12:00.000000',0, NULL, 2 UNION ALL
select 55,3, 3, '1', NULL, '2012-01-05 15:12:00.000000', '2012-01-06 11:18:00.000000',0, NULL, 3 UNION ALL
select 56,4, 3, '1', NULL, '2012-01-06 11:18:00.000000', '2012-01-07 14:24:00.000000',0, NULL, 4 UNION ALL
select 57,5, 3, '1', NULL, '2012-01-07 14:24:00.000000', '2012-01-07 14:25:00.000000',0, NULL, 5 UNION ALL

select 58,1, 3, '2', NULL, '2011-12-30 11:32:00.000000', '2011-12-30 12:12:00.000000',0, NULL, 1 UNION ALL
select 59,3, 3, '2', NULL, '2011-12-30 12:12:00.000000', '2011-12-30 14:16:00.000000',0, NULL, 3 UNION ALL
select 60,6, 3, '2', NULL, '2011-12-30 14:16:00.000000', '2012-01-05 11:22:00.000000',0, NULL, 6 UNION ALL
select 61,4, 3, '2', NULL, '2012-01-05 11:22:00.000000', '2012-01-08 12:05:00.000000',0, NULL, 4 UNION ALL
select 62,7, 3, '2', NULL, '2012-01-08 12:05:00.000000', '2012-01-08 12:06:00.000000',0, NULL, 7 UNION ALL

select 63,1, 3, '3', NULL, '2011-12-30 14:32:00.000000', '2011-12-30 15:06:00.000000',0, NULL, 1 UNION ALL
select 64,6, 3, '3', NULL, '2011-12-30 15:06:00.000000', '2011-12-30 16:34:00.000000',0, NULL, 6 UNION ALL
select 65,3, 3, '3', NULL, '2011-12-30 16:34:00.000000', '2012-01-06 09:18:00.000000',0, NULL, 3 UNION ALL
select 66,4, 3, '3', NULL, '2012-01-06 09:18:00.000000', '2012-01-06 12:18:00.000000',0, NULL, 4 UNION ALL
select 67,8, 3, '3', NULL, '2012-01-06 12:18:00.000000', '2012-01-06 13:06:00.000000',0, NULL, 8 UNION ALL
select 68,2, 3, '3', NULL, '2012-01-06 13:06:00.000000', '2012-01-08 11:43:00.000000',0, NULL, 2 UNION ALL
select 69,3, 3, '3', NULL, '2012-01-08 11:43:00.000000', '2012-01-09 09:55:00.000000',0, NULL, 3 UNION ALL
select 70,4, 3, '3', NULL, '2012-01-09 09:55:00.000000', '2012-01-15 10:45:00.000000',0, NULL, 4 UNION ALL
select 71,7, 3, '3', NULL, '2012-01-15 10:45:00.000000', '2012-01-15 10:46:00.000000',0, NULL, 7 UNION ALL

select 72,1, 3, '4', NULL, '2012-01-06 15:02:00.000000', '2012-01-07 12:06:00.000000',0, NULL, 1 UNION ALL
select 73,3, 3, '4', NULL, '2012-01-07 12:06:00.000000', '2012-01-08 14:43:00.000000',0, NULL, 3 UNION ALL
select 74,2, 3, '4', NULL, '2012-01-08 14:43:00.000000', '2012-01-09 12:02:00.000000',0, NULL, 2 UNION ALL
select 75,4, 3, '4', NULL, '2012-01-09 12:02:00.000000', '2012-01-12 15:44:00.000000',0, NULL, 4 UNION ALL
select 76,5, 3, '4', NULL, '2012-01-12 15:44:00.000000', '2012-01-12 15:45:00.000000',0, NULL, 5 UNION ALL

select 77,1, 3, '5', NULL, '2012-01-06 09:02:00.000000', '2012-01-07 10:16:00.000000',0, NULL, 1 UNION ALL
select 78,6, 3, '5', NULL, '2012-01-07 10:16:00.000000', '2012-01-08 11:22:00.000000',0, NULL, 6 UNION ALL
select 79,3, 3, '5', NULL, '2012-01-08 11:22:00.000000', '2012-01-10 13:28:00.000000',0, NULL, 3 UNION ALL
select 80,4, 3, '5', NULL, '2012-01-10 13:28:00.000000', '2012-01-11 16:18:00.000000',0, NULL, 4 UNION ALL
select 81,8, 3, '5', NULL, '2012-01-11 16:18:00.000000', '2012-01-14 14:33:00.000000',0, NULL, 8 UNION ALL
select 82,3, 3, '5', NULL, '2012-01-14 14:33:00.000000', '2012-01-16 15:50:00.000000',0, NULL, 3 UNION ALL
select 83,6, 3, '5', NULL, '2012-01-16 15:50:00.000000', '2012-01-19 11:18:00.000000',0, NULL, 6 UNION ALL
select 84,4, 3, '5', NULL, '2012-01-19 11:18:00.000000', '2012-01-20 12:48:00.000000',0, NULL, 4 UNION ALL
select 85,8, 3, '5', NULL, '2012-01-20 12:48:00.000000', '2012-01-21 09:06:00.000000',0, NULL, 8 UNION ALL
select 86,6, 3, '5', NULL, '2012-01-21 09:06:00.000000', '2012-01-21 11:34:00.000000',0, NULL, 6 UNION ALL
select 87,3, 3, '5', NULL, '2012-01-21 11:34:00.000000', '2012-01-23 13:12:00.000000',0, NULL, 3 UNION ALL
select 88,4, 3, '5', NULL, '2012-01-23 13:12:00.000000', '2012-01-24 14:56:00.000000',0, NULL, 4 UNION ALL
select 89,5, 3, '5', NULL, '2012-01-24 14:56:00.000000', '2012-01-24 14:57:00.000000',0, NULL, 5 UNION ALL

select 90,1, 3, '6', NULL, '2012-01-06 15:02:00.000000', '2012-01-06 16:06:00.000000',0, NULL, 1 UNION ALL
select 91,6, 3, '6', NULL, '2012-01-06 16:06:00.000000', '2012-01-07 16:22:00.000000',0, NULL, 6 UNION ALL
select 92,3, 3, '6', NULL, '2012-01-07 16:22:00.000000', '2012-01-07 16:52:00.000000',0, NULL, 3 UNION ALL
select 93,4, 3, '6', NULL, '2012-01-07 16:52:00.000000', '2012-01-16 11:47:00.000000',0, NULL, 4 UNION ALL
select 94,7, 3, '6', NULL, '2012-01-16 11:47:00.000000', '2012-01-16 11:48:00.000000',0, NULL, 7 UNION ALL

select 95,1, 3, '7', NULL, '2012-01-15 12:00:00.000000', '2012-01-16 12:00:00.000000',0, NULL, 1 UNION ALL
select 96,2, 3, '7', NULL, '2012-01-16 12:00:00.000000', '2012-01-17 12:00:00.000000',0, NULL, 2 UNION ALL
select 97,4, 3, '7', NULL, '2012-01-17 12:00:00.000000', '2012-01-18 12:00:00.000000',0, NULL, 4 UNION ALL
select 98,5, 3, '7', NULL, '2012-01-18 12:00:00.000000', '2012-01-18 12:01:00.000000',0, NULL, 5 UNION ALL

select 99,1, 3, '8', NULL,  '2012-01-19 12:00:00.000000', '2012-01-20 12:00:00.000000',0, NULL, 1 UNION ALL
select 101,2, 3, '8', NULL, '2012-01-20 12:00:00.000000', '2012-01-21 12:00:00.000000',0, NULL, 2 UNION ALL
select 102,3, 3, '8', NULL, '2012-01-21 12:00:00.000000', '2012-01-22 12:00:00.000000',0, NULL, 3 UNION ALL
select 103,4, 3, '8', NULL, '2012-01-22 12:00:00.000000', '2012-01-22 12:01:00.000000',0, NULL, 4 UNION ALL

select 104,1, 3, '9', NULL, '2012-01-06 09:02:00.000000', '2012-01-07 10:16:00.000000',0, NULL, 1 UNION ALL
select 105,3, 3, '9', NULL, '2012-01-07 10:16:00.000000', '2012-01-08 11:22:00.000000',0, NULL, 3 UNION ALL
select 106,6, 3, '9', NULL, '2012-01-08 11:22:00.000000', '2012-01-10 13:28:00.000000',0, NULL, 6 UNION ALL
select 107,4, 3, '9', NULL, '2012-01-10 13:28:00.000000', '2012-01-11 16:18:00.000000',0, NULL, 4 UNION ALL
select 108,8, 3, '9', NULL, '2012-01-11 16:18:00.000000', '2012-01-14 14:33:00.000000',0, NULL, 8 UNION ALL
select 109,3, 3, '9', NULL, '2012-01-14 14:33:00.000000', '2012-01-16 15:50:00.000000',0, NULL, 3 UNION ALL
select 110,6, 3, '9', NULL, '2012-01-16 15:50:00.000000', '2012-01-19 11:18:00.000000',0, NULL, 6 UNION ALL
select 111,4, 3, '9', NULL, '2012-01-19 11:18:00.000000', '2012-01-20 12:48:00.000000',0, NULL, 4 UNION ALL
select 112,8, 3, '9', NULL, '2012-01-20 12:48:00.000000', '2012-01-21 09:06:00.000000',0, NULL, 8 UNION ALL
select 113,2, 3, '9', NULL, '2012-01-21 09:06:00.000000', '2012-01-21 11:34:00.000000',0, NULL, 2 UNION ALL
select 114,3, 3, '9', NULL, '2012-01-21 11:34:00.000000', '2012-01-23 13:12:00.000000',0, NULL, 3 UNION ALL
select 115,4, 3, '9', NULL, '2012-01-23 13:12:00.000000', '2012-01-24 14:56:00.000000',0, NULL, 4 UNION ALL
select 116,5, 3, '9', NULL, '2012-01-24 14:56:00.000000', '2012-01-24 14:57:00.000000',0, NULL, 5 UNION ALL

select 117,1, 3, '10', NULL, '2011-12-30 14:32:00.000000', '2011-12-30 15:06:00.000000',0, NULL, 1 UNION ALL
select 118,6, 3, '10', NULL, '2011-12-30 15:06:00.000000', '2011-12-30 16:34:00.000000',0, NULL, 6 UNION ALL
select 119,3, 3, '10', NULL, '2011-12-30 16:34:00.000000', '2012-01-06 09:18:00.000000',0, NULL, 3 UNION ALL
select 120,4, 3, '10', NULL, '2012-01-06 09:18:00.000000', '2012-01-06 12:18:00.000000',0, NULL, 4 UNION ALL
select 121,8, 3, '10', NULL, '2012-01-06 12:18:00.000000', '2012-01-06 13:06:00.000000',0, NULL, 8 UNION ALL
select 122,2, 3, '10', NULL, '2012-01-06 13:06:00.000000', '2012-01-08 11:43:00.000000',0, NULL, 2 UNION ALL
select 123,3, 3, '10', NULL, '2012-01-08 11:43:00.000000', '2012-01-15 10:45:00.000000',0, NULL, 3 UNION ALL
select 124,7, 3, '10', NULL, '2012-01-15 10:45:00.000000', '2012-01-15 10:46:00.000000',0, NULL, 7;

SET IDENTITY_INSERT ncfinderdb.dbo.EVENTS OFF;