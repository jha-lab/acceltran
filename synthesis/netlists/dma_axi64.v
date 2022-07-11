
module dma_axi64 ( clk, reset, scan_en, idle, INT, periph_tx_req, 
        periph_tx_clr, periph_rx_req, periph_rx_clr, pclken, psel, penable, 
        paddr, pwrite, pwdata, prdata, pslverr, pready, AWID0, AWADDR0, AWLEN0, 
        AWSIZE0, AWVALID0, AWREADY0, WID0, WDATA0, WSTRB0, WLAST0, WVALID0, 
        WREADY0, BID0, BRESP0, BVALID0, BREADY0, ARID0, ARADDR0, ARLEN0, 
        ARSIZE0, ARVALID0, ARREADY0, RID0, RDATA0, RRESP0, RLAST0, RVALID0, 
        RREADY0 );
  output [0:0] INT;
  input [31:1] periph_tx_req;
  output [31:1] periph_tx_clr;
  input [31:1] periph_rx_req;
  output [31:1] periph_rx_clr;
  input [12:0] paddr;
  input [31:0] pwdata;
  output [31:0] prdata;
  output [0:0] AWID0;
  output [31:0] AWADDR0;
  output [3:0] AWLEN0;
  output [1:0] AWSIZE0;
  output [0:0] WID0;
  output [63:0] WDATA0;
  output [7:0] WSTRB0;
  input [0:0] BID0;
  input [1:0] BRESP0;
  output [0:0] ARID0;
  output [31:0] ARADDR0;
  output [3:0] ARLEN0;
  output [1:0] ARSIZE0;
  input [0:0] RID0;
  input [63:0] RDATA0;
  input [1:0] RRESP0;
  input clk, reset, scan_en, pclken, psel, penable, pwrite, AWREADY0, WREADY0,
         BVALID0, ARREADY0, RLAST0, RVALID0;
  output idle, pslverr, pready, AWVALID0, WLAST0, WVALID0, BREADY0, ARVALID0,
         RREADY0;
  wire   \dma_axi64_dual_core/prdata_reg[0] ,
         \dma_axi64_dual_core/dma_axi64_apb_mux/n4 ,
         \dma_axi64_dual_core/dma_axi64_apb_mux/n5 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1149 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1148 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1147 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1146 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1142 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1141 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1140 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1139 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1138 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1137 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1136 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1135 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1134 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1133 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1132 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1131 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1130 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1129 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1128 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1127 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1126 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1125 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1124 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1123 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1122 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1121 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1120 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1119 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1118 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1117 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1116 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1115 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1114 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1113 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1112 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1111 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1110 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1109 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1108 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1107 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1106 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1105 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1104 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1103 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1102 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1101 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1100 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1099 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1098 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1097 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1096 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1095 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1094 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1093 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1092 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1091 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1090 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1089 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1088 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1087 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1086 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1085 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1084 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1083 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1082 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1081 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1063 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1062 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1061 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1060 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1059 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1058 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1057 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1056 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1055 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1054 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1053 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1052 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1051 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1050 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1049 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1047 , n493, n494, n495, n496,
         n497, n498, n499, n500, n501, n502, n503, n504, n505, n506, n507,
         n508, n509, n510, n511, n512, n513, n514, n515, n516, n517, n518,
         n519, n520, n521, n522, n523, n524, n525, n526, n527, n528, n529,
         n530, n531, n532, n533, n534, n535, n536, n537, n539, n540, n541,
         n543, n544, n545, n546, n547, n548, n549, n550, n551, n552, n553,
         n554, n555, n556, n557, n558, n559, n560, n561, n562, n563, n564,
         n565, n566, n567, n568, n569, n570, n571, n572, n573, n574, n575,
         n576, n577, n578, n579, n580, n581, n582, n583, n584, n585, n586,
         n587, n588, n589, n590, n591, n592, n593, n594, n595, n596, n597,
         n598, n599, n600, n601, n602, n603, n604, n605, n606, n607, n608,
         n609, n610, n611, n612, n613, n614, n615, n616, n617, n618, n619,
         n620, n621, n622, n623, n624, n625, n626, n627, n628, n629, n630,
         n631, n632, n633, n634, n635, n636, n637, n638, n639, n640, n641,
         n642, n643, n644, n645, n646, n647, n648, n649, n650, n651, n652,
         n653, n654, n655, n656, n657, n658, n659, n660, n661, n662, n663,
         n664, n665, n666, n667, n668, n669, n670, n671, n672, n673, n674,
         n675, n676, n677, n678, n679, n680, n681, n682, n683, n684, n685,
         n686, n687, n688, n689, n690, n691, n692, n693, n694, n695, n696,
         n697, n698, n699, n700, n701, n702, n703, n704, n705, n706, n707,
         n708, n709, n710, n711, n712, n713, n714, n715, n716, n717, n718,
         n719, n720, n721, n722, n723, n724, n725, n726, n727, n728, n729,
         n730, n731, n732, n733, n734, n735, n736, n737, n738, n739, n740,
         n741, n742, n743, n744, n745, n746, n747, n748, n749, n750, n751,
         n752, n753, n754, n755, n756, n757, n758, n759, n760, n761, n762,
         n763, n764, n765, n766, n767, n768, n769, n770, n771, n772, n773,
         n774, n775, n776, n777, n778, n779, n780, n781, n782, n783, n784,
         n785, n786, n787, n788, n789, n790, n791, n792, n793, n794, n795,
         n796, n797, n798, n799, n800, n801, n802, n803, n804, n805, n806,
         n807, n808, n809, n810, n811, n812, n813, n814, n815, n816, n817,
         n818, n819, n820, n821, n822, n823, n824, n825, n826, n827, n828,
         n829, n830, n831, n832, n833, n834, n835, n836, n837, n838, n839,
         n840, n841, n842, n843, n844, n845, n846, n847, n848, n849, n850,
         n851, n852, n853, n854, n855, n856, n857, n858, n859, n860, n861,
         n862, n863, n864, n865, n866, n867, n868, n869, n870, n871, n872,
         n873, n874, n875, n876, n877, n878, n879, n880, n881, n882, n883,
         n884, n885, n886, n887, n888, n889, n890, n891, n892, n893, n894,
         n895, n896, n897, n898, n899, n900, n901, n902, n903, n904, n905,
         n906, n907, n908, n909, n910, n911, n912, n913, n914, n915, n916,
         n917, n918, n919, n920, n921, n922, n923, n924, n925, n926, n927,
         n928, n929, n930, n931, n932, n933, n934, n935, n936, n937, n938,
         n939, n940, n941, n942, n943, n944, n945, n946, n947, n948, n949,
         n950, n951, n952, n953, n954, n955, n956, n957, n958, n959, n960,
         n961, n962, n963, n964, n965, n966, n967, n968, n969, n970, n971,
         n972, n973, n974, n975, n976, n977, n978, n979, n980, n981, n982,
         n983, n984, n985, n986, n987, n988, n989, n990, n991, n992, n993,
         n994, n995, n996, n997, n998, n999, n1000, n1001, n1002, n1003, n1004,
         n1005, n1006, n1007, n1008, n1009, n1010, n1011, n1012, n1013, n1014,
         n1015, n1016, n1017, n1018, n1019, n1020, n1021, n1022, n1023, n1024,
         n1025, n1026, n1027, n1028, n1029, n1030, n1031, n1032, n1033, n1034,
         n1035, n1036, n1037, n1038, n1039, n1040, n1041, n1042, n1043, n1044,
         n1045, n1046, n1047, n1048, n1049, n1050, n1051, n1052, n1053, n1054,
         n1055, n1056, n1057, n1058, n1059, n1060, n1061, n1062, n1063, n1064,
         n1065, n1066, n1067, n1068, n1069, n1070, n1071, n1072, n1073, n1074,
         n1075, n1076, n1077, n1078, n1079, n1080, n1081, n1082, n1083, n1084,
         n1085, n1086, n1087, n1088, n1089, n1090, n1091, n1092, n1093, n1094,
         n1095, n1096, n1097, n1098, n1099, n1100, n1101, n1102, n1103, n1104,
         n1105, n1106, n1107, n1108, n1109, n1110, n1111, n1112, n1113, n1114,
         n1115, n1116, n1117, n1118, n1119, n1120, n1121, n1122, n1123, n1124,
         n1125, n1126, n1127, n1128, n1129, n1130, n1131, n1132, n1133, n1134,
         n1135, n1136, n1137, n1138, n1139, n1140, n1141, n1142, n1143, n1144,
         n1145, n1146, n1147, n1148, n1149, n1150, n1151, n1152, n1153, n1154,
         n1155, n1156, n1157, n1158, n1159, n1160, n1161, n1162, n1163, n1164,
         n1165, n1166, n1167, n1168, n1169, n1170, n1171, n1172, n1173, n1174,
         n1175, n1176, n1177, n1178, n1179, n1180, n1181, n1182, n1183, n1184,
         n1185, n1186, n1187, n1188, n1189, n1190, n1191, n1192, n1193, n1194,
         n1195, n1196, n1197, n1198, n1199, n1200, n1201, n1202, n1203, n1204,
         n1205, n1206, n1207, n1208, n1209, n1210, n1211, n1212, n1213, n1214,
         n1215, n1216, n1217, n1218, n1219, n1220, n1221, n1222, n1223, n1224,
         n1225, n1226, n1227, n1228, n1229, n1230, n1250, n1251, n1252, n1253,
         n1254, n1255, n1256, n1257, n1258, n1259, n1260, n1261, n1262, n1263,
         n1264, n1265, n1266, n1267, n1268, n1269, n1270, n1271, n1272, n1273,
         n1274, n1275, n1276, n1277, n1278, n1279, n1280, n1281, n1282, n1283,
         n1284, n1285, n1286, n1287, n1288, n1289, n1290, n1291, n1292, n1293,
         n1294, n1295, n1296, n1297, n1298, n1299, n1300, n1301, n1302, n1303,
         n1304, n1305, n1306, n1307, n1308, n1309, n1310, n1311, n1312, n1313,
         n1314, n1315, n1316, n1317, n1318, n1319, n1320, n1321, n1322, n1323,
         n1324, n1325, n1326, n1327, n1328, n1329, n1330, n1331, n1332, n1333,
         n1334, n1335, n1336, n1337, n1338, n1339, n1340, n1341, n1342, n1343,
         n1344, n1345, n1346, n1347, n1348, n1349, n1350, n1351, n1352, n1353,
         n1354, n1355, n1356, n1357, n1358, n1359, n1360, n1361, n1362, n1363,
         n1364, n1365, n1366, n1367, n1368, n1369, n1370, n1371, n1372, n1373,
         n1374, n1375, n1376, n1377, n1378, n1379, n1380, n1381, n1382, n1383,
         n1384, n1385, n1386, n1387, n1388, n1389, n1390, n1391, n1392, n1393,
         n1394, n1395, n1396, n1397, n1398, n1399, n1400, n1401, n1402, n1403,
         n1404, n1405, n1406, n1407, n1408, n1409, n1410, n1411, n1412, n1413,
         n1414, n1415, n1416, n1417, n1418, n1419, n1420, n1421, n1422, n1423,
         n1424, n1425, n1426, n1427, n1428, n1429, n1430, n1431, n1432, n1433,
         n1434, n1435, n1436, n1437, n1438, n1439, n1440, n1441, n1442, n1443,
         n1444, n1445, n1446, n1447, n1448, n1449, n1450, n1451, n1452, n1453,
         n1454, n1455, n1456, n1457, n1458, n1459, n1460, n1461, n1462, n1463,
         n1464, n1465, n1466, n1467, n1468, n1469, n1470, n1471, n1472, n1473,
         n1474, n1475, n1476, n1477, n1478, n1479, n1480, n1481, n1482, n1483,
         n1484, n1485, n1486, n1487, n1488, n1489, n1490, n1491, n1492, n1493,
         n1494, n1495, n1496, n1497, n1498, n1499, n1500, n1501, n1502, n1503,
         n1504, n1505, n1506, n1507, n1508, n1509, n1510, n1511, n1512, n1513,
         n1514, n1515, n1516, n1517, n1518, n1519, n1520, n1521, n1522, n1814,
         n1815, n1816, n1817, n1818, n1819, n1820, n1821, n1822, n1823, n1824,
         n1825, n1826, n1827, n1828, n1829, n1830, n1831, n1832, n1833, n1834,
         n1835, n1836, n1837, n1838, n1839, n1840, n1841, n1842, n1843, n1844,
         n1845, n1846, n1847, n1848, n1849, n1850, n1851, n1852, n1853, n1854,
         n1855, n1856, n1857, n1858, n1859, n1860, n1861, n1862, n1863, n1864,
         n1865, n1866, n1867, n1868, n1869, n1870, n1871, n1872, n1873, n1874,
         n1875, n1876, n1877, n1878, n1879, n1880, n1881, n1882, n1883, n1884,
         n1885, n1886, n1887, n1888, n1889, n1890, n1891, n1892, n1893, n1894,
         n1895, n1896, n1897, n1898, n1899, n1900, n1901, n1902, n1903, n1904,
         n1905, n1906, n1907, n1908, n1909, n1910;
  tri   clk;
  tri   reset;
  tri   scan_en;
  tri   idle;
  tri   [31:1] periph_tx_clr;
  tri   [31:1] periph_rx_clr;
  tri   pclken;
  tri   penable;
  tri   [12:0] paddr;
  tri   pwrite;
  tri   [31:0] pwdata;
  tri   [31:0] AWADDR0;
  tri   [3:0] AWLEN0;
  tri   [1:0] AWSIZE0;
  tri   AWVALID0;
  tri   AWREADY0;
  tri   [63:0] WDATA0;
  tri   [7:0] WSTRB0;
  tri   WLAST0;
  tri   WVALID0;
  tri   WREADY0;
  tri   [1:0] BRESP0;
  tri   BVALID0;
  tri   BREADY0;
  tri   [31:0] ARADDR0;
  tri   [3:0] ARLEN0;
  tri   [1:0] ARSIZE0;
  tri   ARVALID0;
  tri   ARREADY0;
  tri   [63:0] RDATA0;
  tri   [1:0] RRESP0;
  tri   RLAST0;
  tri   RVALID0;
  tri   RREADY0;
  tri   \dma_axi64_dual_core/n3 ;
  tri   [2:0] \dma_axi64_dual_core/wr_prio_high_num0 ;
  tri   [2:0] \dma_axi64_dual_core/wr_prio_top_num0 ;
  tri   \dma_axi64_dual_core/wr_prio_high0 ;
  tri   \dma_axi64_dual_core/wr_prio_top0 ;
  tri   [2:0] \dma_axi64_dual_core/rd_prio_high_num0 ;
  tri   [2:0] \dma_axi64_dual_core/rd_prio_top_num0 ;
  tri   \dma_axi64_dual_core/rd_prio_high0 ;
  tri   \dma_axi64_dual_core/rd_prio_top0 ;
  tri   [7:0] \dma_axi64_dual_core/core0_ch_start ;
  tri   [3:0] \dma_axi64_dual_core/core0_clkdiv ;
  tri   [7:0] \dma_axi64_dual_core/ch_int_all_proc0 ;
  tri   \dma_axi64_dual_core/pslverr1 ;
  tri   \dma_axi64_dual_core/psel1 ;
  tri   \dma_axi64_dual_core/pslverr0 ;
  tri   [31:0] \dma_axi64_dual_core/prdata0 ;
  tri   \dma_axi64_dual_core/psel0 ;
  tri   \dma_axi64_dual_core/joint_mode0 ;
  tri   [31:1] \dma_axi64_dual_core/periph_tx_req0 ;
  tri   [31:1] \dma_axi64_dual_core/periph_rx_req0 ;
  tri   \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[0] ;
  tri   \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[1] ;
  tri   \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[2] ;
  tri   \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[3] ;
  tri   \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[4] ;
  tri   \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[5] ;
  tri   \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[6] ;
  tri   \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[7] ;
  tri   [31:0] \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 ;
  tri   [31:0] \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 ;
  tri   \dma_axi64_dual_core/dma_axi64_reg/wr_prio0 ;
  tri   \dma_axi64_dual_core/dma_axi64_reg/wr_start0 ;
  tri   \dma_axi64_dual_core/dma_axi64_reg/wr_clkdiv0 ;
  tri   \dma_axi64_dual_core/dma_axi64_reg/wr_joint0 ;
  assign ARID0[0] = 1'b0;
  assign WID0[0] = 1'b0;
  assign AWID0[0] = 1'b0;

  prgen_delay \dma_axi64_dual_core/delay_pslverr1  ( .clk(clk), .reset(reset), 
        .din(\dma_axi64_dual_core/psel1 ), .dout(
        \dma_axi64_dual_core/pslverr1 ) );
  dma_axi64_core0_top \dma_axi64_dual_core/dma_axi64_core0_top  ( .clk(clk), 
        .reset(reset), .scan_en(scan_en), .idle(idle), .ch_int_all_proc(
        \dma_axi64_dual_core/ch_int_all_proc0 ), .ch_start(
        \dma_axi64_dual_core/core0_ch_start ), .clkdiv(
        \dma_axi64_dual_core/core0_clkdiv ), .periph_tx_req(
        \dma_axi64_dual_core/periph_tx_req0 ), .periph_tx_clr(periph_tx_clr), 
        .periph_rx_req(\dma_axi64_dual_core/periph_rx_req0 ), .periph_rx_clr(
        periph_rx_clr), .pclken(pclken), .psel(\dma_axi64_dual_core/psel0 ), 
        .penable(penable), .paddr(paddr[10:0]), .pwrite(pwrite), .pwdata(
        pwdata), .prdata(\dma_axi64_dual_core/prdata0 ), .pslverr(
        \dma_axi64_dual_core/pslverr0 ), .joint_mode(
        \dma_axi64_dual_core/joint_mode0 ), .joint_remote(1'b0), .rd_prio_top(
        \dma_axi64_dual_core/rd_prio_top0 ), .rd_prio_high(
        \dma_axi64_dual_core/rd_prio_high0 ), .rd_prio_top_num(
        \dma_axi64_dual_core/rd_prio_top_num0 ), .rd_prio_high_num(
        \dma_axi64_dual_core/rd_prio_high_num0 ), .wr_prio_top(
        \dma_axi64_dual_core/wr_prio_top0 ), .wr_prio_high(
        \dma_axi64_dual_core/wr_prio_high0 ), .wr_prio_top_num(
        \dma_axi64_dual_core/wr_prio_top_num0 ), .wr_prio_high_num(
        \dma_axi64_dual_core/wr_prio_high_num0 ), .AWADDR(AWADDR0), .AWLEN(
        AWLEN0), .AWSIZE(AWSIZE0), .AWVALID(AWVALID0), .AWREADY(AWREADY0), 
        .WDATA(WDATA0), .WSTRB(WSTRB0), .WLAST(WLAST0), .WVALID(WVALID0), 
        .WREADY(WREADY0), .BRESP(BRESP0), .BVALID(BVALID0), .BREADY(BREADY0), 
        .ARADDR(ARADDR0), .ARLEN(ARLEN0), .ARSIZE(ARSIZE0), .ARVALID(ARVALID0), 
        .ARREADY(ARREADY0), .RDATA(RDATA0), .RRESP(RRESP0), .RLAST(RLAST0), 
        .RVALID(RVALID0), .RREADY(RREADY0) );
  dma_axi64_reg_core0 \dma_axi64_dual_core/dma_axi64_reg/dma_axi64_reg_core0  ( 
        .clk(clk), .reset(reset), .wr_joint(
        \dma_axi64_dual_core/dma_axi64_reg/wr_joint0 ), .wr_clkdiv(
        \dma_axi64_dual_core/dma_axi64_reg/wr_clkdiv0 ), .wr_start(
        \dma_axi64_dual_core/dma_axi64_reg/wr_start0 ), .wr_prio(
        \dma_axi64_dual_core/dma_axi64_reg/wr_prio0 ), .pwdata(pwdata), 
        .clkdiv(\dma_axi64_dual_core/core0_clkdiv ), .ch_start(
        \dma_axi64_dual_core/core0_ch_start ), .joint_mode(
        \dma_axi64_dual_core/joint_mode0 ), .rd_prio_top(
        \dma_axi64_dual_core/rd_prio_top0 ), .rd_prio_high(
        \dma_axi64_dual_core/rd_prio_high0 ), .rd_prio_top_num(
        \dma_axi64_dual_core/rd_prio_top_num0 ), .rd_prio_high_num(
        \dma_axi64_dual_core/rd_prio_high_num0 ), .wr_prio_top(
        \dma_axi64_dual_core/wr_prio_top0 ), .wr_prio_high(
        \dma_axi64_dual_core/wr_prio_high0 ), .wr_prio_top_num(
        \dma_axi64_dual_core/wr_prio_top_num0 ), .wr_prio_high_num(
        \dma_axi64_dual_core/wr_prio_high_num0 ), .user_def_stat0(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 ), .user_def_stat1(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 ), 
        .ch_int_all_proc(\dma_axi64_dual_core/ch_int_all_proc0 ), 
        .proc0_int_stat({
        \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[7] , 
        \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[6] , 
        \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[5] , 
        \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[4] , 
        \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[3] , 
        \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[2] , 
        \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[1] , 
        \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[0] }) );
  nand_x8_sg U536 ( .A(n716), .B(n717), .X(n715) );
  nand_x8_sg U539 ( .A(n718), .B(n719), .X(n714) );
  nand_x8_sg U675 ( .A(n825), .B(n826), .X(n824) );
  nor_x2_sg U676 ( .A(n827), .B(n828), .X(n826) );
  nand_x8_sg U677 ( .A(n829), .B(n830), .X(n828) );
  nand_x8_sg U680 ( .A(n831), .B(n832), .X(n827) );
  nor_x2_sg U683 ( .A(n833), .B(n834), .X(n825) );
  nand_x8_sg U684 ( .A(n835), .B(n836), .X(n834) );
  nand_x8_sg U687 ( .A(n837), .B(n838), .X(n833) );
  nand_x8_sg U690 ( .A(n839), .B(n840), .X(n823) );
  nor_x2_sg U691 ( .A(n841), .B(n842), .X(n840) );
  nand_x8_sg U692 ( .A(n843), .B(n844), .X(n842) );
  nand_x8_sg U695 ( .A(n845), .B(n846), .X(n841) );
  nor_x2_sg U700 ( .A(n848), .B(n849), .X(n839) );
  nand_x8_sg U701 ( .A(n850), .B(n851), .X(n849) );
  nand_x8_sg U704 ( .A(n852), .B(n853), .X(n848) );
  nand_x8_sg U863 ( .A(n981), .B(n982), .X(n980) );
  nor_x2_sg U864 ( .A(n983), .B(n984), .X(n982) );
  nand_x8_sg U865 ( .A(n985), .B(n986), .X(n984) );
  nand_x8_sg U868 ( .A(n987), .B(n988), .X(n983) );
  nor_x2_sg U871 ( .A(n989), .B(n990), .X(n981) );
  nand_x8_sg U872 ( .A(n991), .B(n992), .X(n990) );
  nand_x8_sg U875 ( .A(n993), .B(n994), .X(n989) );
  nand_x8_sg U878 ( .A(n995), .B(n996), .X(n979) );
  nor_x2_sg U879 ( .A(n997), .B(n998), .X(n996) );
  nand_x8_sg U880 ( .A(n999), .B(n1000), .X(n998) );
  nand_x8_sg U883 ( .A(n1001), .B(n1002), .X(n997) );
  nor_x2_sg U888 ( .A(n1006), .B(n1007), .X(n995) );
  nand_x8_sg U889 ( .A(n1008), .B(n1009), .X(n1007) );
  nand_x8_sg U892 ( .A(n1010), .B(n1011), .X(n1006) );
  nand_x8_sg U1113 ( .A(n1211), .B(n1908), .X(n705) );
  nand_x8_sg U1120 ( .A(paddr[12]), .B(n1520), .X(n1203) );
  nor_x2_sg U1146 ( .A(n1230), .B(pclken), .X(n1227) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_apb_mux/pready_reg  ( 
        .next_state(n1250), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(pready) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/pslverr_reg  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1047 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1230) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[0]  ( .next_state(
        n1251), .clocked_on(clk), .force_00(1'b0), .force_01(reset), 
        .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/prdata_reg[0] ) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[1]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1049 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .Q(n1321) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[2]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1050 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .Q(n1322) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[3]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1051 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .Q(n1323) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[4]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1052 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1362) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[5]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1053 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1363) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[6]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1054 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1364) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[7]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1055 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1365) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[8]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1056 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1366) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[9]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1057 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1367) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[10]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1058 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .QN(n1368) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[11]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1059 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .QN(n1369) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[12]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1060 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .QN(n1370) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[13]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1061 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .QN(n1371) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[14]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1062 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .QN(n1372) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[15]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1063 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .QN(n1373) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[16]  ( 
        .next_state(n1887), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1324) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[17]  ( 
        .next_state(n1893), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1325) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[18]  ( 
        .next_state(n1890), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1326) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[19]  ( 
        .next_state(n1886), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1374) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[20]  ( 
        .next_state(n1885), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1327) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[21]  ( 
        .next_state(n1899), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1328) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[22]  ( 
        .next_state(n1891), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1329) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[23]  ( 
        .next_state(n1895), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1330) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[24]  ( 
        .next_state(n1888), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1331) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[25]  ( 
        .next_state(n1900), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1332) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[26]  ( 
        .next_state(n1889), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1333) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[27]  ( 
        .next_state(n1894), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1334) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[28]  ( 
        .next_state(n1892), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1335) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[29]  ( 
        .next_state(n1896), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1336) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[30]  ( 
        .next_state(n1898), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1337) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[31]  ( 
        .next_state(n1897), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(n1338) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/int_all_proc_reg[0]  ( 
        .next_state(n1910), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(INT[0]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[1]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1081 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1320), .QN(n1252) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[2]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1082 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1319), .QN(n1253) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[3]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1083 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1318), .QN(n1254) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[4]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1084 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1342), .QN(n1255) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[5]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1085 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1341), .QN(n1256) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[6]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1086 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1340), .QN(n1257) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[7]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1087 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1339), .QN(n1258) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[8]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1088 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1361), .QN(n1259) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[9]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1089 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1360), .QN(n1260) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[10]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1090 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1359), .QN(n1261) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[11]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1091 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1358), .QN(n1262) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[12]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1092 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1357), .QN(n1263) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[13]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1093 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1356), .QN(n1264) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[14]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1094 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1355), .QN(n1265) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[15]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1095 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1354), .QN(n1266) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[16]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1096 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1402), .QN(n1267) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[17]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1097 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1406), .QN(n1268) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[18]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1098 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1405), .QN(n1269) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[19]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1099 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1401), .QN(n1270) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[20]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1100 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1400), .QN(n1271) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[21]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1101 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1399), .QN(n1272) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[22]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1102 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1398), .QN(n1273) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[23]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1103 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1397), .QN(n1274) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[24]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1104 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1396), .QN(n1275) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[25]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1105 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1395), .QN(n1276) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[26]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1106 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1394), .QN(n1277) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[27]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1107 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1393), .QN(n1278) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[28]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1108 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1392), .QN(n1279) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[29]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1109 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1391), .QN(n1280) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[30]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1110 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1390), .QN(n1281) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[31]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1111 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1389), .QN(n1282) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[1]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1112 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1353), .QN(n1283) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[2]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1113 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1352), .QN(n1284) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[3]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1114 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1351), .QN(n1285) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[4]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1115 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1317), .QN(n1286) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[5]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1116 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1316), .QN(n1287) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[6]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1117 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1315), .QN(n1288) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[7]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1118 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1314), .QN(n1289) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[8]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1119 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1350), .QN(n1290) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[9]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1120 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1349), .QN(n1291) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[10]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1121 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1348), .QN(n1292) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[11]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1122 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1347), .QN(n1293) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[12]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1123 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1346), .QN(n1294) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[13]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1124 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1345), .QN(n1295) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[14]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1125 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1344), .QN(n1296) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[15]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1126 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1343), .QN(n1297) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[16]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1127 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1388), .QN(n1298) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[17]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1128 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1404), .QN(n1299) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[18]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1129 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1403), .QN(n1300) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[19]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1130 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1387), .QN(n1301) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[20]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1131 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1386), .QN(n1302) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[21]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1132 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1385), .QN(n1303) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[22]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1133 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1384), .QN(n1304) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[23]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1134 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1383), .QN(n1305) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[24]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1135 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1382), .QN(n1306) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[25]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1136 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1381), .QN(n1307) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[26]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1137 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1380), .QN(n1308) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[27]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1138 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1379), .QN(n1309) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[28]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1139 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1378), .QN(n1310) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[29]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1140 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1377), .QN(n1311) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[30]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1141 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1376), .QN(n1312) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[31]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1142 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(n1375), .QN(n1313) );
  nor_x1_sg \dma_axi64_dual_core/dma_axi64_apb_mux/U9  ( .A(
        \dma_axi64_dual_core/dma_axi64_apb_mux/n4 ), .B(n1515), .X(
        \dma_axi64_dual_core/psel0 ) );
  inv_x1_sg \dma_axi64_dual_core/dma_axi64_reg/U1140  ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/n1149 ), .X(
        \dma_axi64_dual_core/dma_axi64_reg/wr_prio0 ) );
  inv_x1_sg \dma_axi64_dual_core/dma_axi64_reg/U1138  ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/n1147 ), .X(
        \dma_axi64_dual_core/dma_axi64_reg/wr_clkdiv0 ) );
  inv_x1_sg \dma_axi64_dual_core/dma_axi64_reg/U1137  ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/n1146 ), .X(
        \dma_axi64_dual_core/dma_axi64_reg/wr_joint0 ) );
  inv_x1_sg \dma_axi64_dual_core/dma_axi64_apb_mux/U6  ( .A(
        \dma_axi64_dual_core/dma_axi64_apb_mux/n5 ), .X(
        \dma_axi64_dual_core/psel1 ) );
  nand_x1_sg \dma_axi64_dual_core/C162  ( .A(n1814), .B(n1282), .X(
        \dma_axi64_dual_core/periph_tx_req0 [31]) );
  nand_x1_sg \dma_axi64_dual_core/C163  ( .A(n1815), .B(n1281), .X(
        \dma_axi64_dual_core/periph_tx_req0 [30]) );
  nand_x1_sg \dma_axi64_dual_core/C164  ( .A(n1816), .B(n1280), .X(
        \dma_axi64_dual_core/periph_tx_req0 [29]) );
  nand_x1_sg \dma_axi64_dual_core/C165  ( .A(n1817), .B(n1279), .X(
        \dma_axi64_dual_core/periph_tx_req0 [28]) );
  nand_x1_sg \dma_axi64_dual_core/C166  ( .A(n1818), .B(n1278), .X(
        \dma_axi64_dual_core/periph_tx_req0 [27]) );
  nand_x1_sg \dma_axi64_dual_core/C167  ( .A(n1819), .B(n1277), .X(
        \dma_axi64_dual_core/periph_tx_req0 [26]) );
  nand_x1_sg \dma_axi64_dual_core/C168  ( .A(n1820), .B(n1276), .X(
        \dma_axi64_dual_core/periph_tx_req0 [25]) );
  nand_x1_sg \dma_axi64_dual_core/C169  ( .A(n1821), .B(n1275), .X(
        \dma_axi64_dual_core/periph_tx_req0 [24]) );
  nand_x1_sg \dma_axi64_dual_core/C170  ( .A(n1822), .B(n1274), .X(
        \dma_axi64_dual_core/periph_tx_req0 [23]) );
  nand_x1_sg \dma_axi64_dual_core/C171  ( .A(n1823), .B(n1273), .X(
        \dma_axi64_dual_core/periph_tx_req0 [22]) );
  nand_x1_sg \dma_axi64_dual_core/C172  ( .A(n1824), .B(n1272), .X(
        \dma_axi64_dual_core/periph_tx_req0 [21]) );
  nand_x1_sg \dma_axi64_dual_core/C173  ( .A(n1825), .B(n1271), .X(
        \dma_axi64_dual_core/periph_tx_req0 [20]) );
  nand_x1_sg \dma_axi64_dual_core/C174  ( .A(n1826), .B(n1270), .X(
        \dma_axi64_dual_core/periph_tx_req0 [19]) );
  nand_x1_sg \dma_axi64_dual_core/C175  ( .A(n1827), .B(n1269), .X(
        \dma_axi64_dual_core/periph_tx_req0 [18]) );
  nand_x1_sg \dma_axi64_dual_core/C176  ( .A(n1828), .B(n1268), .X(
        \dma_axi64_dual_core/periph_tx_req0 [17]) );
  nand_x1_sg \dma_axi64_dual_core/C177  ( .A(n1829), .B(n1267), .X(
        \dma_axi64_dual_core/periph_tx_req0 [16]) );
  nand_x1_sg \dma_axi64_dual_core/C178  ( .A(n1830), .B(n1266), .X(
        \dma_axi64_dual_core/periph_tx_req0 [15]) );
  nand_x1_sg \dma_axi64_dual_core/C179  ( .A(n1831), .B(n1265), .X(
        \dma_axi64_dual_core/periph_tx_req0 [14]) );
  nand_x1_sg \dma_axi64_dual_core/C180  ( .A(n1832), .B(n1264), .X(
        \dma_axi64_dual_core/periph_tx_req0 [13]) );
  nand_x1_sg \dma_axi64_dual_core/C181  ( .A(n1833), .B(n1263), .X(
        \dma_axi64_dual_core/periph_tx_req0 [12]) );
  nand_x1_sg \dma_axi64_dual_core/C182  ( .A(n1834), .B(n1262), .X(
        \dma_axi64_dual_core/periph_tx_req0 [11]) );
  nand_x1_sg \dma_axi64_dual_core/C183  ( .A(n1835), .B(n1261), .X(
        \dma_axi64_dual_core/periph_tx_req0 [10]) );
  nand_x1_sg \dma_axi64_dual_core/C184  ( .A(n1836), .B(n1260), .X(
        \dma_axi64_dual_core/periph_tx_req0 [9]) );
  nand_x1_sg \dma_axi64_dual_core/C185  ( .A(n1837), .B(n1259), .X(
        \dma_axi64_dual_core/periph_tx_req0 [8]) );
  nand_x1_sg \dma_axi64_dual_core/C186  ( .A(n1838), .B(n1258), .X(
        \dma_axi64_dual_core/periph_tx_req0 [7]) );
  nand_x1_sg \dma_axi64_dual_core/C187  ( .A(n1839), .B(n1257), .X(
        \dma_axi64_dual_core/periph_tx_req0 [6]) );
  nand_x1_sg \dma_axi64_dual_core/C188  ( .A(n1840), .B(n1256), .X(
        \dma_axi64_dual_core/periph_tx_req0 [5]) );
  nand_x1_sg \dma_axi64_dual_core/C189  ( .A(n1841), .B(n1255), .X(
        \dma_axi64_dual_core/periph_tx_req0 [4]) );
  nand_x1_sg \dma_axi64_dual_core/C190  ( .A(n1842), .B(n1254), .X(
        \dma_axi64_dual_core/periph_tx_req0 [3]) );
  nand_x1_sg \dma_axi64_dual_core/C191  ( .A(n1843), .B(n1253), .X(
        \dma_axi64_dual_core/periph_tx_req0 [2]) );
  nand_x1_sg \dma_axi64_dual_core/C192  ( .A(n1844), .B(n1252), .X(
        \dma_axi64_dual_core/periph_tx_req0 [1]) );
  nand_x1_sg \dma_axi64_dual_core/C131  ( .A(n1845), .B(n1313), .X(
        \dma_axi64_dual_core/periph_rx_req0 [31]) );
  nand_x1_sg \dma_axi64_dual_core/C132  ( .A(n1846), .B(n1312), .X(
        \dma_axi64_dual_core/periph_rx_req0 [30]) );
  nand_x1_sg \dma_axi64_dual_core/C133  ( .A(n1847), .B(n1311), .X(
        \dma_axi64_dual_core/periph_rx_req0 [29]) );
  nand_x1_sg \dma_axi64_dual_core/C134  ( .A(n1848), .B(n1310), .X(
        \dma_axi64_dual_core/periph_rx_req0 [28]) );
  nand_x1_sg \dma_axi64_dual_core/C135  ( .A(n1849), .B(n1309), .X(
        \dma_axi64_dual_core/periph_rx_req0 [27]) );
  nand_x1_sg \dma_axi64_dual_core/C136  ( .A(n1850), .B(n1308), .X(
        \dma_axi64_dual_core/periph_rx_req0 [26]) );
  nand_x1_sg \dma_axi64_dual_core/C137  ( .A(n1851), .B(n1307), .X(
        \dma_axi64_dual_core/periph_rx_req0 [25]) );
  nand_x1_sg \dma_axi64_dual_core/C138  ( .A(n1852), .B(n1306), .X(
        \dma_axi64_dual_core/periph_rx_req0 [24]) );
  nand_x1_sg \dma_axi64_dual_core/C139  ( .A(n1853), .B(n1305), .X(
        \dma_axi64_dual_core/periph_rx_req0 [23]) );
  nand_x1_sg \dma_axi64_dual_core/C140  ( .A(n1854), .B(n1304), .X(
        \dma_axi64_dual_core/periph_rx_req0 [22]) );
  nand_x1_sg \dma_axi64_dual_core/C141  ( .A(n1855), .B(n1303), .X(
        \dma_axi64_dual_core/periph_rx_req0 [21]) );
  nand_x1_sg \dma_axi64_dual_core/C142  ( .A(n1856), .B(n1302), .X(
        \dma_axi64_dual_core/periph_rx_req0 [20]) );
  nand_x1_sg \dma_axi64_dual_core/C143  ( .A(n1857), .B(n1301), .X(
        \dma_axi64_dual_core/periph_rx_req0 [19]) );
  nand_x1_sg \dma_axi64_dual_core/C144  ( .A(n1858), .B(n1300), .X(
        \dma_axi64_dual_core/periph_rx_req0 [18]) );
  nand_x1_sg \dma_axi64_dual_core/C145  ( .A(n1859), .B(n1299), .X(
        \dma_axi64_dual_core/periph_rx_req0 [17]) );
  nand_x1_sg \dma_axi64_dual_core/C146  ( .A(n1860), .B(n1298), .X(
        \dma_axi64_dual_core/periph_rx_req0 [16]) );
  nand_x1_sg \dma_axi64_dual_core/C147  ( .A(n1861), .B(n1297), .X(
        \dma_axi64_dual_core/periph_rx_req0 [15]) );
  nand_x1_sg \dma_axi64_dual_core/C148  ( .A(n1862), .B(n1296), .X(
        \dma_axi64_dual_core/periph_rx_req0 [14]) );
  nand_x1_sg \dma_axi64_dual_core/C149  ( .A(n1863), .B(n1295), .X(
        \dma_axi64_dual_core/periph_rx_req0 [13]) );
  nand_x1_sg \dma_axi64_dual_core/C150  ( .A(n1864), .B(n1294), .X(
        \dma_axi64_dual_core/periph_rx_req0 [12]) );
  nand_x1_sg \dma_axi64_dual_core/C151  ( .A(n1865), .B(n1293), .X(
        \dma_axi64_dual_core/periph_rx_req0 [11]) );
  nand_x1_sg \dma_axi64_dual_core/C152  ( .A(n1866), .B(n1292), .X(
        \dma_axi64_dual_core/periph_rx_req0 [10]) );
  nand_x1_sg \dma_axi64_dual_core/C153  ( .A(n1867), .B(n1291), .X(
        \dma_axi64_dual_core/periph_rx_req0 [9]) );
  nand_x1_sg \dma_axi64_dual_core/C154  ( .A(n1868), .B(n1290), .X(
        \dma_axi64_dual_core/periph_rx_req0 [8]) );
  nand_x1_sg \dma_axi64_dual_core/C155  ( .A(n1869), .B(n1289), .X(
        \dma_axi64_dual_core/periph_rx_req0 [7]) );
  nand_x1_sg \dma_axi64_dual_core/C156  ( .A(n1870), .B(n1288), .X(
        \dma_axi64_dual_core/periph_rx_req0 [6]) );
  nand_x1_sg \dma_axi64_dual_core/C157  ( .A(n1871), .B(n1287), .X(
        \dma_axi64_dual_core/periph_rx_req0 [5]) );
  nand_x1_sg \dma_axi64_dual_core/C158  ( .A(n1872), .B(n1286), .X(
        \dma_axi64_dual_core/periph_rx_req0 [4]) );
  nand_x1_sg \dma_axi64_dual_core/C159  ( .A(n1873), .B(n1285), .X(
        \dma_axi64_dual_core/periph_rx_req0 [3]) );
  nand_x1_sg \dma_axi64_dual_core/C160  ( .A(n1874), .B(n1284), .X(
        \dma_axi64_dual_core/periph_rx_req0 [2]) );
  nand_x1_sg \dma_axi64_dual_core/C161  ( .A(n1875), .B(n1283), .X(
        \dma_axi64_dual_core/periph_rx_req0 [1]) );
  inv_x1_sg \dma_axi64_dual_core/dma_axi64_reg/U1139  ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/n1148 ), .X(
        \dma_axi64_dual_core/dma_axi64_reg/wr_start0 ) );
  nand_x4_sg U1350 ( .A(n1214), .B(pwrite), .X(n1201) );
  nand_x2_sg U1351 ( .A(n1169), .B(n1170), .X(n1165) );
  nor_x1_sg U1352 ( .A(n1907), .B(paddr[7]), .X(n1178) );
  nand_x4_sg U1353 ( .A(paddr[3]), .B(
        \dma_axi64_dual_core/rd_prio_top_num0 [0]), .X(n688) );
  nor_x2_sg U1354 ( .A(n723), .B(paddr[3]), .X(n1183) );
  nand_x2_sg U1355 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [31]), .B(n1469), 
        .X(n567) );
  nand_x2_sg U1356 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [30]), .B(n1470), 
        .X(n558) );
  nand_x2_sg U1357 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [29]), .B(n1411), 
        .X(n576) );
  nand_x2_sg U1358 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [28]), .B(n1432), 
        .X(n612) );
  nand_x2_sg U1359 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [27]), .B(n1467), 
        .X(n594) );
  nand_x1_sg U1360 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [27]), .B(n1419), 
        .X(n592) );
  nand_x2_sg U1361 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [26]), .B(n1432), 
        .X(n639) );
  nand_x1_sg U1362 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [26]), .B(n1484), 
        .X(n637) );
  nand_x2_sg U1363 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [25]), .B(n1431), 
        .X(n537) );
  nand_x1_sg U1364 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [25]), .B(n1437), 
        .X(n534) );
  nand_x2_sg U1365 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [24]), .B(n1468), 
        .X(n648) );
  nand_x1_sg U1366 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [24]), .B(n1485), 
        .X(n646) );
  nand_x2_sg U1367 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [23]), .B(n1467), 
        .X(n585) );
  nand_x1_sg U1368 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [23]), .B(n1437), 
        .X(n583) );
  nand_x2_sg U1369 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [22]), .B(n1470), 
        .X(n621) );
  nand_x1_sg U1370 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [22]), .B(n1438), 
        .X(n619) );
  nand_x2_sg U1371 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [21]), .B(n1411), 
        .X(n549) );
  nand_x1_sg U1372 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [21]), .B(n1420), 
        .X(n547) );
  nand_x2_sg U1373 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [20]), .B(n1432), 
        .X(n675) );
  nand_x1_sg U1374 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [20]), .B(n1419), 
        .X(n673) );
  nand_x2_sg U1375 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [19]), .B(n1468), 
        .X(n666) );
  nand_x2_sg U1376 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [19]), .B(n1485), 
        .X(n664) );
  nand_x2_sg U1377 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [18]), .B(n1410), 
        .X(n630) );
  nand_x1_sg U1378 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [18]), .B(n1437), 
        .X(n628) );
  nand_x2_sg U1379 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [17]), .B(n1469), 
        .X(n603) );
  nand_x1_sg U1380 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [17]), .B(n1419), 
        .X(n601) );
  nand_x2_sg U1381 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [16]), .B(n1470), 
        .X(n657) );
  nand_x1_sg U1382 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [16]), .B(n1438), 
        .X(n655) );
  nand_x1_sg U1383 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [15]), .B(n1483), 
        .X(n1020) );
  nand_x1_sg U1384 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [15]), .B(n1431), 
        .X(n1017) );
  nand_x1_sg U1385 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [14]), .B(n1482), 
        .X(n1031) );
  nand_x1_sg U1386 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [14]), .B(n1468), 
        .X(n1028) );
  nand_x1_sg U1387 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [13]), .B(n1420), 
        .X(n1041) );
  nand_x1_sg U1388 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [13]), .B(n1469), 
        .X(n1038) );
  nand_x1_sg U1389 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [12]), .B(n1438), 
        .X(n1051) );
  nand_x1_sg U1390 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [12]), .B(n1431), 
        .X(n1048) );
  nand_x1_sg U1391 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [11]), .B(n1484), 
        .X(n1061) );
  nand_x1_sg U1392 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [11]), .B(n1469), 
        .X(n1058) );
  nand_x1_sg U1393 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [10]), .B(n1482), 
        .X(n1071) );
  nand_x1_sg U1394 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [10]), .B(n1410), 
        .X(n1068) );
  nand_x1_sg U1395 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [9]), .B(n1483), .X(n1081) );
  nand_x1_sg U1396 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [9]), .B(n1411), .X(n1078) );
  nand_x1_sg U1397 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [8]), .B(n1484), .X(n1091) );
  nand_x1_sg U1398 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [8]), .B(n1410), .X(n1088) );
  nand_x1_sg U1399 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [7]), .B(n1420), .X(n1104) );
  nand_x1_sg U1400 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [6]), .B(n1485), .X(n1116) );
  nand_x1_sg U1401 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [5]), .B(n1483), .X(n1128) );
  nand_x1_sg U1402 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [4]), .B(n1482), .X(n1140) );
  nand_x1_sg U1403 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [4]), .B(n1432), .X(n1134) );
  nand_x2_sg U1404 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [2]), .B(n1467), .X(n1170) );
  nand_x2_sg U1405 ( .A(\dma_axi64_dual_core/rd_prio_top_num0 [2]), .B(n1444), 
        .X(n1169) );
  nand_x1_sg U1406 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [1]), .B(n1431), .X(n1192) );
  nand_x1_sg U1407 ( .A(n869), .B(n1441), .X(n868) );
  nand_x1_sg U1408 ( .A(n885), .B(n1442), .X(n884) );
  nand_x2_sg U1409 ( .A(n721), .B(n722), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1148 ) );
  nor_x8_sg U1410 ( .A(paddr[12]), .B(paddr[11]), .X(n1228) );
  inv_x1_sg U1411 ( .A(n1455), .X(n1407) );
  inv_x1_sg U1412 ( .A(n1451), .X(n1408) );
  inv_x1_sg U1413 ( .A(n1522), .X(n1409) );
  inv_x1_sg U1414 ( .A(n1409), .X(n1410) );
  inv_x1_sg U1415 ( .A(n1466), .X(n1411) );
  inv_x1_sg U1416 ( .A(n858), .X(n1412) );
  inv_x1_sg U1417 ( .A(n858), .X(n1471) );
  inv_x1_sg U1418 ( .A(n1471), .X(n1413) );
  inv_x1_sg U1419 ( .A(n1471), .X(n1414) );
  inv_x1_sg U1420 ( .A(n732), .X(n1415) );
  inv_x1_sg U1421 ( .A(n732), .X(n1476) );
  inv_x1_sg U1422 ( .A(n1476), .X(n1416) );
  inv_x1_sg U1423 ( .A(n1476), .X(n1417) );
  inv_x1_sg U1424 ( .A(n535), .X(n1418) );
  inv_x1_sg U1425 ( .A(n535), .X(n1481) );
  nor_x1_sg U1426 ( .A(n1190), .B(n1504), .X(n535) );
  inv_x1_sg U1427 ( .A(n1481), .X(n1419) );
  inv_x1_sg U1428 ( .A(n1481), .X(n1420) );
  inv_x1_sg U1429 ( .A(n731), .X(n1421) );
  inv_x1_sg U1430 ( .A(n1421), .X(n1422) );
  inv_x1_sg U1431 ( .A(n1486), .X(n1423) );
  inv_x1_sg U1432 ( .A(n1499), .X(n1424) );
  inv_x1_sg U1433 ( .A(n1424), .X(n1425) );
  inv_x1_sg U1434 ( .A(n1491), .X(n1426) );
  inv_x4_sg U1435 ( .A(pclken), .X(n1427) );
  inv_x4_sg U1436 ( .A(pclken), .X(n1428) );
  inv_x4_sg U1437 ( .A(pclken), .X(n529) );
  inv_x1_sg U1438 ( .A(n1099), .X(n1429) );
  inv_x1_sg U1439 ( .A(n1429), .X(n1430) );
  inv_x1_sg U1440 ( .A(n1409), .X(n1431) );
  inv_x1_sg U1441 ( .A(n1466), .X(n1432) );
  inv_x1_sg U1442 ( .A(n1471), .X(n1433) );
  inv_x1_sg U1443 ( .A(n1471), .X(n1434) );
  inv_x1_sg U1444 ( .A(n1476), .X(n1435) );
  inv_x1_sg U1445 ( .A(n1476), .X(n1436) );
  inv_x1_sg U1446 ( .A(n1481), .X(n1437) );
  inv_x1_sg U1447 ( .A(n1481), .X(n1438) );
  inv_x1_sg U1448 ( .A(n1421), .X(n1439) );
  inv_x1_sg U1449 ( .A(n1486), .X(n1440) );
  inv_x1_sg U1450 ( .A(n1424), .X(n1441) );
  inv_x1_sg U1451 ( .A(n1491), .X(n1442) );
  inv_x1_sg U1452 ( .A(n1022), .X(n1443) );
  inv_x1_sg U1453 ( .A(n1443), .X(n1444) );
  inv_x1_sg U1454 ( .A(n1443), .X(n1445) );
  inv_x1_sg U1455 ( .A(n1443), .X(n1446) );
  inv_x1_sg U1456 ( .A(n1443), .X(n1447) );
  inv_x1_sg U1457 ( .A(n1408), .X(n1448) );
  inv_x1_sg U1458 ( .A(n541), .X(n1449) );
  inv_x1_sg U1459 ( .A(n1408), .X(n1450) );
  inv_x1_sg U1460 ( .A(n541), .X(n1451) );
  inv_x1_sg U1461 ( .A(n1407), .X(n1452) );
  inv_x1_sg U1462 ( .A(n1511), .X(n1453) );
  inv_x1_sg U1463 ( .A(n1407), .X(n1454) );
  inv_x1_sg U1464 ( .A(n1511), .X(n1455) );
  inv_x1_sg U1465 ( .A(n1511), .X(n1456) );
  inv_x1_sg U1466 ( .A(n1456), .X(n1457) );
  inv_x1_sg U1467 ( .A(n1456), .X(n1458) );
  inv_x1_sg U1468 ( .A(n1456), .X(n1459) );
  inv_x1_sg U1469 ( .A(n1456), .X(n1460) );
  inv_x1_sg U1470 ( .A(n541), .X(n1461) );
  inv_x1_sg U1471 ( .A(n1461), .X(n1462) );
  inv_x1_sg U1472 ( .A(n1461), .X(n1463) );
  inv_x1_sg U1473 ( .A(n1461), .X(n1464) );
  inv_x1_sg U1474 ( .A(n1461), .X(n1465) );
  inv_x1_sg U1475 ( .A(n1522), .X(n1466) );
  inv_x1_sg U1476 ( .A(n1409), .X(n1467) );
  inv_x1_sg U1477 ( .A(n1466), .X(n1468) );
  inv_x1_sg U1478 ( .A(n1409), .X(n1469) );
  inv_x1_sg U1479 ( .A(n1466), .X(n1470) );
  inv_x1_sg U1480 ( .A(n1412), .X(n1472) );
  inv_x1_sg U1481 ( .A(n1412), .X(n1473) );
  inv_x1_sg U1482 ( .A(n1412), .X(n1474) );
  inv_x1_sg U1483 ( .A(n1412), .X(n1475) );
  inv_x1_sg U1484 ( .A(n1415), .X(n1477) );
  inv_x1_sg U1485 ( .A(n1415), .X(n1478) );
  inv_x1_sg U1486 ( .A(n1415), .X(n1479) );
  inv_x1_sg U1487 ( .A(n1415), .X(n1480) );
  inv_x1_sg U1488 ( .A(n1418), .X(n1482) );
  inv_x1_sg U1489 ( .A(n1418), .X(n1483) );
  inv_x1_sg U1490 ( .A(n1418), .X(n1484) );
  inv_x1_sg U1491 ( .A(n1418), .X(n1485) );
  inv_x1_sg U1492 ( .A(n731), .X(n1486) );
  inv_x1_sg U1493 ( .A(n1421), .X(n1487) );
  inv_x1_sg U1494 ( .A(n1486), .X(n1488) );
  inv_x1_sg U1495 ( .A(n1421), .X(n1489) );
  inv_x1_sg U1496 ( .A(n1486), .X(n1490) );
  inv_x1_sg U1497 ( .A(n1499), .X(n1491) );
  inv_x1_sg U1498 ( .A(n1424), .X(n1492) );
  inv_x1_sg U1499 ( .A(n1491), .X(n1493) );
  inv_x1_sg U1500 ( .A(n1424), .X(n1494) );
  inv_x1_sg U1501 ( .A(n1491), .X(n1495) );
  inv_x8_sg U1502 ( .A(pclken), .X(n1501) );
  inv_x16_sg U1503 ( .A(paddr[3]), .X(n1519) );
  nor_x2_sg U1504 ( .A(pwrite), .B(n690), .X(n1218) );
  inv_x4_sg U1505 ( .A(pclken), .X(n1496) );
  inv_x2_sg U1506 ( .A(pclken), .X(n1497) );
  inv_x1_sg U1507 ( .A(n1423), .X(n1498) );
  inv_x1_sg U1508 ( .A(n1003), .X(n1499) );
  nand_x2_sg U1509 ( .A(\dma_axi64_dual_core/prdata_reg[0] ), .B(n1501), .X(
        n678) );
  nand_x2_sg U1510 ( .A(pready), .B(n1502), .X(n526) );
  inv_x8_sg U1511 ( .A(pclken), .X(n1500) );
  nand_x4_sg U1512 ( .A(n1374), .B(n1502), .X(n663) );
  nor_x1_sg U1513 ( .A(n1193), .B(n1521), .X(n1522) );
  nand_x4_sg U1514 ( .A(\dma_axi64_dual_core/joint_mode0 ), .B(n1512), .X(n689) );
  inv_x16_sg U1515 ( .A(pclken), .X(n1502) );
  nand_x1_sg U1516 ( .A(n1507), .B(n1004), .X(n1511) );
  nor_x2_sg U1517 ( .A(n979), .B(n980), .X(n858) );
  nor_x2_sg U1518 ( .A(n823), .B(n824), .X(n732) );
  nand_x4_sg U1519 ( .A(n1177), .B(n1178), .X(n541) );
  nand_x4_sg U1520 ( .A(n847), .B(n1506), .X(n731) );
  nand_x2_sg U1521 ( .A(n1199), .B(n1200), .X(n1198) );
  nand_x2_sg U1522 ( .A(n1201), .B(n1181), .X(n1200) );
  nor_x8_sg U1523 ( .A(pwrite), .B(penable), .X(n1202) );
  inv_x1_sg U1524 ( .A(n687), .X(n1503) );
  nand_x4_sg U1525 ( .A(n688), .B(n689), .X(n687) );
  inv_x16_sg U1526 ( .A(n1005), .X(n1904) );
  inv_x1_sg U1527 ( .A(n1194), .X(n1504) );
  inv_x1_sg U1528 ( .A(n680), .X(n1505) );
  inv_x1_sg U1529 ( .A(n725), .X(n1506) );
  nand_x2_sg U1530 ( .A(n700), .B(n1509), .X(n709) );
  inv_x16_sg U1531 ( .A(paddr[4]), .X(n1509) );
  nor_x1_sg U1532 ( .A(n1181), .B(n1904), .X(n1507) );
  nand_x16_sg U1533 ( .A(n1202), .B(n1901), .X(n1181) );
  nand_x4_sg U1534 ( .A(n1508), .B(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [0]), .X(n712) );
  nor_x2_sg U1535 ( .A(n1195), .B(n1514), .X(n1194) );
  nand_x8_sg U1536 ( .A(n1183), .B(paddr[5]), .X(n1195) );
  nor_x4_sg U1537 ( .A(periph_tx_clr[4]), .B(periph_tx_clr[5]), .X(n993) );
  nor_x4_sg U1538 ( .A(periph_rx_clr[4]), .B(periph_rx_clr[5]), .X(n837) );
  nor_x2_sg U1539 ( .A(n1517), .B(paddr[2]), .X(n1508) );
  nor_x1_sg U1540 ( .A(n1509), .B(paddr[2]), .X(n1513) );
  nand_x16_sg U1541 ( .A(n1212), .B(n1213), .X(n724) );
  nor_x8_sg U1542 ( .A(paddr[4]), .B(paddr[2]), .X(n1212) );
  nor_x8_sg U1543 ( .A(paddr[7]), .B(paddr[5]), .X(n1213) );
  nand_x16_sg U1544 ( .A(n1183), .B(n1185), .X(n692) );
  nor_x4_sg U1545 ( .A(periph_tx_clr[26]), .B(periph_tx_clr[27]), .X(n987) );
  nor_x4_sg U1546 ( .A(periph_rx_clr[26]), .B(periph_rx_clr[27]), .X(n831) );
  inv_x16_sg U1547 ( .A(paddr[6]), .X(n1510) );
  nand_x1_sg U1548 ( .A(n861), .B(n1442), .X(n860) );
  nand_x2_sg U1549 ( .A(n1204), .B(n1205), .X(n1199) );
  nor_x4_sg U1550 ( .A(periph_tx_clr[15]), .B(periph_tx_clr[16]), .X(n999) );
  nor_x4_sg U1551 ( .A(periph_rx_clr[15]), .B(periph_rx_clr[16]), .X(n843) );
  nor_x4_sg U1552 ( .A(periph_tx_clr[31]), .B(periph_tx_clr[3]), .X(n994) );
  nor_x4_sg U1553 ( .A(periph_tx_clr[24]), .B(periph_tx_clr[25]), .X(n988) );
  nor_x4_sg U1554 ( .A(periph_rx_clr[31]), .B(periph_rx_clr[3]), .X(n838) );
  nor_x4_sg U1555 ( .A(periph_rx_clr[24]), .B(periph_rx_clr[25]), .X(n832) );
  inv_x16_sg U1556 ( .A(paddr[3]), .X(n1512) );
  inv_x8_sg U1557 ( .A(idle), .X(n695) );
  nor_x4_sg U1558 ( .A(paddr[6]), .B(paddr[3]), .X(n1211) );
  inv_x16_sg U1559 ( .A(paddr[6]), .X(n723) );
  inv_x16_sg U1560 ( .A(paddr[4]), .X(n1517) );
  nand_x1_sg U1561 ( .A(n1506), .B(n1004), .X(n1003) );
  nor_x4_sg U1562 ( .A(periph_tx_clr[19]), .B(periph_tx_clr[1]), .X(n1010) );
  nor_x4_sg U1563 ( .A(periph_tx_clr[17]), .B(periph_tx_clr[18]), .X(n1011) );
  nor_x4_sg U1564 ( .A(periph_rx_clr[19]), .B(periph_rx_clr[1]), .X(n852) );
  nor_x4_sg U1565 ( .A(periph_rx_clr[17]), .B(periph_rx_clr[18]), .X(n853) );
  nor_x4_sg U1566 ( .A(periph_tx_clr[13]), .B(periph_tx_clr[14]), .X(n1000) );
  nor_x4_sg U1567 ( .A(periph_tx_clr[8]), .B(periph_tx_clr[9]), .X(n991) );
  nor_x4_sg U1568 ( .A(periph_tx_clr[2]), .B(periph_tx_clr[30]), .X(n985) );
  nor_x4_sg U1569 ( .A(periph_rx_clr[13]), .B(periph_rx_clr[14]), .X(n844) );
  nor_x4_sg U1570 ( .A(periph_rx_clr[8]), .B(periph_rx_clr[9]), .X(n835) );
  nor_x4_sg U1571 ( .A(periph_rx_clr[2]), .B(periph_rx_clr[30]), .X(n829) );
  nor_x2_sg U1572 ( .A(paddr[6]), .B(n1512), .X(n1220) );
  nand_x4_sg U1573 ( .A(n1229), .B(paddr[11]), .X(
        \dma_axi64_dual_core/dma_axi64_apb_mux/n5 ) );
  nand_x8_sg U1574 ( .A(n1876), .B(n1005), .X(n725) );
  inv_x16_sg U1575 ( .A(paddr[2]), .X(n700) );
  nand_x16_sg U1576 ( .A(n1197), .B(paddr[5]), .X(n686) );
  inv_x16_sg U1577 ( .A(paddr[7]), .X(n1514) );
  inv_x16_sg U1578 ( .A(paddr[7]), .X(n702) );
  nor_x4_sg U1579 ( .A(periph_tx_clr[22]), .B(periph_tx_clr[23]), .X(n1008) );
  nor_x4_sg U1580 ( .A(periph_tx_clr[20]), .B(periph_tx_clr[21]), .X(n1009) );
  nor_x4_sg U1581 ( .A(periph_rx_clr[22]), .B(periph_rx_clr[23]), .X(n850) );
  nor_x4_sg U1582 ( .A(periph_rx_clr[20]), .B(periph_rx_clr[21]), .X(n851) );
  nor_x4_sg U1583 ( .A(periph_tx_clr[11]), .B(periph_tx_clr[12]), .X(n1001) );
  nor_x4_sg U1584 ( .A(periph_tx_clr[6]), .B(periph_tx_clr[7]), .X(n992) );
  nor_x4_sg U1585 ( .A(periph_tx_clr[28]), .B(periph_tx_clr[29]), .X(n986) );
  nor_x4_sg U1586 ( .A(periph_rx_clr[11]), .B(periph_rx_clr[12]), .X(n845) );
  nor_x4_sg U1587 ( .A(periph_rx_clr[6]), .B(periph_rx_clr[7]), .X(n836) );
  nor_x4_sg U1588 ( .A(periph_rx_clr[28]), .B(periph_rx_clr[29]), .X(n830) );
  inv_x8_sg U1589 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[0] ), 
        .X(n706) );
  inv_x8_sg U1590 ( .A(n1228), .X(n1515) );
  inv_x8_sg U1591 ( .A(paddr[5]), .X(n1516) );
  inv_x16_sg U1592 ( .A(paddr[5]), .X(n1185) );
  nor_x16_sg U1593 ( .A(paddr[0]), .B(paddr[1]), .X(n1005) );
  inv_x8_sg U1594 ( .A(paddr[4]), .X(n1518) );
  inv_x8_sg U1595 ( .A(paddr[4]), .X(n701) );
  inv_x16_sg U1596 ( .A(paddr[3]), .X(n690) );
  nor_x1_sg U1597 ( .A(n1196), .B(n686), .X(n1022) );
  nor_x1_sg U1598 ( .A(n698), .B(n699), .X(n693) );
  inv_x1_sg U1599 ( .A(n712), .X(n1905) );
  nand_x1_sg U1600 ( .A(n709), .B(n710), .X(n708) );
  nand_x1_sg U1601 ( .A(n1015), .B(n1016), .X(n1014) );
  nand_x1_sg U1602 ( .A(n1026), .B(n1027), .X(n1025) );
  nand_x1_sg U1603 ( .A(n1036), .B(n1037), .X(n1035) );
  nand_x1_sg U1604 ( .A(n1046), .B(n1047), .X(n1045) );
  nand_x1_sg U1605 ( .A(n1056), .B(n1057), .X(n1055) );
  nand_x1_sg U1606 ( .A(n1066), .B(n1067), .X(n1065) );
  nand_x1_sg U1607 ( .A(n1076), .B(n1077), .X(n1075) );
  nand_x1_sg U1608 ( .A(n1086), .B(n1087), .X(n1085) );
  nand_x1_sg U1609 ( .A(n1100), .B(n1101), .X(n1095) );
  nand_x1_sg U1610 ( .A(n1112), .B(n1113), .X(n1108) );
  nand_x1_sg U1611 ( .A(n1124), .B(n1125), .X(n1120) );
  nand_x1_sg U1612 ( .A(n1136), .B(n1137), .X(n1132) );
  nand_x1_sg U1613 ( .A(\dma_axi64_dual_core/rd_prio_top0 ), .B(n1444), .X(
        n1155) );
  nand_x1_sg U1614 ( .A(n1148), .B(n1149), .X(n1144) );
  nand_x1_sg U1615 ( .A(\dma_axi64_dual_core/core0_clkdiv [3]), .B(n1150), .X(
        n1149) );
  nand_x1_sg U1616 ( .A(n1146), .B(n1147), .X(n1145) );
  nand_x1_sg U1617 ( .A(n1153), .B(n1154), .X(n1152) );
  nand_x1_sg U1618 ( .A(n1163), .B(n1164), .X(n1159) );
  nand_x1_sg U1619 ( .A(n1161), .B(n1162), .X(n1160) );
  nand_x1_sg U1620 ( .A(n1167), .B(n1168), .X(n1166) );
  nand_x1_sg U1621 ( .A(n1179), .B(n1180), .X(n1173) );
  nand_x1_sg U1622 ( .A(n1175), .B(n1176), .X(n1174) );
  nand_x1_sg U1623 ( .A(n1188), .B(n1189), .X(n1187) );
  nand_x1_sg U1624 ( .A(n493), .B(n1230), .X(pslverr) );
  nor_x1_sg U1625 ( .A(\dma_axi64_dual_core/pslverr1 ), .B(
        \dma_axi64_dual_core/pslverr0 ), .X(n493) );
  inv_x1_sg U1626 ( .A(n525), .X(prdata[0]) );
  nor_x1_sg U1627 ( .A(\dma_axi64_dual_core/prdata0 [0]), .B(
        \dma_axi64_dual_core/prdata_reg[0] ), .X(n525) );
  inv_x1_sg U1628 ( .A(n713), .X(n1910) );
  nor_x1_sg U1629 ( .A(n714), .B(n715), .X(n713) );
  inv_x1_sg U1630 ( .A(n561), .X(n1897) );
  nor_x1_sg U1631 ( .A(n562), .B(n563), .X(n561) );
  inv_x1_sg U1632 ( .A(n552), .X(n1898) );
  nor_x1_sg U1633 ( .A(n553), .B(n554), .X(n552) );
  inv_x1_sg U1634 ( .A(n570), .X(n1896) );
  nor_x1_sg U1635 ( .A(n571), .B(n572), .X(n570) );
  inv_x1_sg U1636 ( .A(n606), .X(n1892) );
  nor_x1_sg U1637 ( .A(n607), .B(n608), .X(n606) );
  inv_x1_sg U1638 ( .A(n588), .X(n1894) );
  nor_x1_sg U1639 ( .A(n589), .B(n590), .X(n588) );
  inv_x1_sg U1640 ( .A(n633), .X(n1889) );
  nor_x1_sg U1641 ( .A(n634), .B(n635), .X(n633) );
  inv_x1_sg U1642 ( .A(n530), .X(n1900) );
  nor_x1_sg U1643 ( .A(n531), .B(n532), .X(n530) );
  inv_x1_sg U1644 ( .A(n642), .X(n1888) );
  nor_x1_sg U1645 ( .A(n643), .B(n644), .X(n642) );
  inv_x1_sg U1646 ( .A(n579), .X(n1895) );
  nor_x1_sg U1647 ( .A(n580), .B(n581), .X(n579) );
  inv_x1_sg U1648 ( .A(n615), .X(n1891) );
  nor_x1_sg U1649 ( .A(n616), .B(n617), .X(n615) );
  inv_x1_sg U1650 ( .A(n543), .X(n1899) );
  nor_x1_sg U1651 ( .A(n544), .B(n545), .X(n543) );
  inv_x1_sg U1652 ( .A(n669), .X(n1885) );
  nor_x1_sg U1653 ( .A(n670), .B(n671), .X(n669) );
  inv_x1_sg U1654 ( .A(n660), .X(n1886) );
  nor_x1_sg U1655 ( .A(n661), .B(n662), .X(n660) );
  inv_x1_sg U1656 ( .A(n624), .X(n1890) );
  nor_x1_sg U1657 ( .A(n625), .B(n626), .X(n624) );
  inv_x1_sg U1658 ( .A(n597), .X(n1893) );
  nor_x1_sg U1659 ( .A(n598), .B(n599), .X(n597) );
  inv_x1_sg U1660 ( .A(n651), .X(n1887) );
  nor_x1_sg U1661 ( .A(n652), .B(n653), .X(n651) );
  nand_x1_sg U1662 ( .A(n1012), .B(n1013), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1063 ) );
  nand_x1_sg U1663 ( .A(n1020), .B(n1021), .X(n1019) );
  nand_x1_sg U1664 ( .A(n1023), .B(n1024), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1062 ) );
  nand_x1_sg U1665 ( .A(n1031), .B(n1032), .X(n1030) );
  nand_x1_sg U1666 ( .A(n1033), .B(n1034), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1061 ) );
  nand_x1_sg U1667 ( .A(n1041), .B(n1042), .X(n1040) );
  nand_x1_sg U1668 ( .A(n1043), .B(n1044), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1060 ) );
  nand_x1_sg U1669 ( .A(n1051), .B(n1052), .X(n1050) );
  nand_x1_sg U1670 ( .A(n1053), .B(n1054), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1059 ) );
  nand_x1_sg U1671 ( .A(n1061), .B(n1062), .X(n1060) );
  nand_x1_sg U1672 ( .A(n1063), .B(n1064), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1058 ) );
  nand_x1_sg U1673 ( .A(n1071), .B(n1072), .X(n1070) );
  nand_x1_sg U1674 ( .A(n1073), .B(n1074), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1057 ) );
  nand_x1_sg U1675 ( .A(n1081), .B(n1082), .X(n1080) );
  nand_x1_sg U1676 ( .A(n1083), .B(n1084), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1056 ) );
  nand_x1_sg U1677 ( .A(n1091), .B(n1092), .X(n1090) );
  nand_x1_sg U1678 ( .A(n1093), .B(n1094), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1055 ) );
  nand_x1_sg U1679 ( .A(n1104), .B(n1105), .X(n1103) );
  nand_x1_sg U1680 ( .A(n1106), .B(n1107), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1054 ) );
  nand_x1_sg U1681 ( .A(n1116), .B(n1117), .X(n1115) );
  nand_x1_sg U1682 ( .A(n1118), .B(n1119), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1053 ) );
  nand_x1_sg U1683 ( .A(n1128), .B(n1129), .X(n1127) );
  nand_x1_sg U1684 ( .A(n1130), .B(n1131), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1052 ) );
  nand_x1_sg U1685 ( .A(n1140), .B(n1141), .X(n1139) );
  nand_x1_sg U1686 ( .A(n1142), .B(n1143), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1051 ) );
  nor_x1_sg U1687 ( .A(n1151), .B(n1152), .X(n1142) );
  nor_x1_sg U1688 ( .A(n1144), .B(n1145), .X(n1143) );
  nand_x1_sg U1689 ( .A(n1155), .B(n1156), .X(n1151) );
  nand_x1_sg U1690 ( .A(n1157), .B(n1158), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1050 ) );
  nor_x1_sg U1691 ( .A(n1165), .B(n1166), .X(n1157) );
  nor_x1_sg U1692 ( .A(n1159), .B(n1160), .X(n1158) );
  nand_x1_sg U1693 ( .A(n1171), .B(n1172), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1049 ) );
  nor_x1_sg U1694 ( .A(n1186), .B(n1187), .X(n1171) );
  nor_x1_sg U1695 ( .A(n1173), .B(n1174), .X(n1172) );
  inv_x2_sg U1696 ( .A(periph_rx_req[1]), .X(n1875) );
  inv_x2_sg U1697 ( .A(periph_rx_req[2]), .X(n1874) );
  inv_x2_sg U1698 ( .A(periph_rx_req[3]), .X(n1873) );
  inv_x2_sg U1699 ( .A(periph_rx_req[4]), .X(n1872) );
  inv_x2_sg U1700 ( .A(periph_rx_req[5]), .X(n1871) );
  inv_x2_sg U1701 ( .A(periph_rx_req[6]), .X(n1870) );
  inv_x2_sg U1702 ( .A(periph_rx_req[7]), .X(n1869) );
  inv_x2_sg U1703 ( .A(periph_rx_req[8]), .X(n1868) );
  inv_x2_sg U1704 ( .A(periph_rx_req[9]), .X(n1867) );
  inv_x2_sg U1705 ( .A(periph_rx_req[10]), .X(n1866) );
  inv_x2_sg U1706 ( .A(periph_rx_req[11]), .X(n1865) );
  inv_x2_sg U1707 ( .A(periph_rx_req[12]), .X(n1864) );
  inv_x2_sg U1708 ( .A(periph_rx_req[13]), .X(n1863) );
  inv_x2_sg U1709 ( .A(periph_rx_req[14]), .X(n1862) );
  inv_x2_sg U1710 ( .A(periph_rx_req[15]), .X(n1861) );
  inv_x2_sg U1711 ( .A(periph_rx_req[16]), .X(n1860) );
  inv_x2_sg U1712 ( .A(periph_rx_req[17]), .X(n1859) );
  inv_x2_sg U1713 ( .A(periph_rx_req[18]), .X(n1858) );
  inv_x2_sg U1714 ( .A(periph_rx_req[19]), .X(n1857) );
  inv_x2_sg U1715 ( .A(periph_rx_req[20]), .X(n1856) );
  inv_x2_sg U1716 ( .A(periph_rx_req[21]), .X(n1855) );
  inv_x2_sg U1717 ( .A(periph_rx_req[22]), .X(n1854) );
  inv_x2_sg U1718 ( .A(periph_rx_req[23]), .X(n1853) );
  inv_x2_sg U1719 ( .A(periph_rx_req[24]), .X(n1852) );
  inv_x2_sg U1720 ( .A(periph_rx_req[25]), .X(n1851) );
  inv_x2_sg U1721 ( .A(periph_rx_req[26]), .X(n1850) );
  inv_x2_sg U1722 ( .A(periph_rx_req[27]), .X(n1849) );
  inv_x2_sg U1723 ( .A(periph_rx_req[28]), .X(n1848) );
  inv_x2_sg U1724 ( .A(periph_rx_req[29]), .X(n1847) );
  inv_x2_sg U1725 ( .A(periph_rx_req[30]), .X(n1846) );
  inv_x2_sg U1726 ( .A(periph_rx_req[31]), .X(n1845) );
  inv_x2_sg U1727 ( .A(periph_tx_req[1]), .X(n1844) );
  inv_x2_sg U1728 ( .A(periph_tx_req[2]), .X(n1843) );
  inv_x2_sg U1729 ( .A(periph_tx_req[3]), .X(n1842) );
  inv_x2_sg U1730 ( .A(periph_tx_req[4]), .X(n1841) );
  inv_x2_sg U1731 ( .A(periph_tx_req[5]), .X(n1840) );
  inv_x2_sg U1732 ( .A(periph_tx_req[6]), .X(n1839) );
  inv_x2_sg U1733 ( .A(periph_tx_req[7]), .X(n1838) );
  inv_x2_sg U1734 ( .A(periph_tx_req[8]), .X(n1837) );
  inv_x2_sg U1735 ( .A(periph_tx_req[9]), .X(n1836) );
  inv_x2_sg U1736 ( .A(periph_tx_req[10]), .X(n1835) );
  inv_x2_sg U1737 ( .A(periph_tx_req[11]), .X(n1834) );
  inv_x2_sg U1738 ( .A(periph_tx_req[12]), .X(n1833) );
  inv_x2_sg U1739 ( .A(periph_tx_req[13]), .X(n1832) );
  inv_x2_sg U1740 ( .A(periph_tx_req[14]), .X(n1831) );
  inv_x2_sg U1741 ( .A(periph_tx_req[15]), .X(n1830) );
  inv_x2_sg U1742 ( .A(periph_tx_req[16]), .X(n1829) );
  inv_x2_sg U1743 ( .A(periph_tx_req[17]), .X(n1828) );
  inv_x2_sg U1744 ( .A(periph_tx_req[18]), .X(n1827) );
  inv_x2_sg U1745 ( .A(periph_tx_req[19]), .X(n1826) );
  inv_x2_sg U1746 ( .A(periph_tx_req[20]), .X(n1825) );
  inv_x2_sg U1747 ( .A(periph_tx_req[21]), .X(n1824) );
  inv_x2_sg U1748 ( .A(periph_tx_req[22]), .X(n1823) );
  inv_x2_sg U1749 ( .A(periph_tx_req[23]), .X(n1822) );
  inv_x2_sg U1750 ( .A(periph_tx_req[24]), .X(n1821) );
  inv_x2_sg U1751 ( .A(periph_tx_req[25]), .X(n1820) );
  inv_x2_sg U1752 ( .A(periph_tx_req[26]), .X(n1819) );
  inv_x2_sg U1753 ( .A(periph_tx_req[27]), .X(n1818) );
  inv_x2_sg U1754 ( .A(periph_tx_req[28]), .X(n1817) );
  inv_x2_sg U1755 ( .A(periph_tx_req[29]), .X(n1816) );
  inv_x2_sg U1756 ( .A(periph_tx_req[30]), .X(n1815) );
  inv_x2_sg U1757 ( .A(periph_tx_req[31]), .X(n1814) );
  nand_x1_sg U1758 ( .A(n817), .B(n818), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1113 ) );
  nand_x2_sg U1759 ( .A(n819), .B(pwdata[2]), .X(n818) );
  nand_x1_sg U1760 ( .A(n808), .B(n809), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1116 ) );
  nand_x2_sg U1761 ( .A(n810), .B(pwdata[5]), .X(n809) );
  nand_x1_sg U1762 ( .A(n805), .B(n806), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1117 ) );
  nand_x2_sg U1763 ( .A(n807), .B(pwdata[6]), .X(n806) );
  nand_x1_sg U1764 ( .A(n793), .B(n794), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1121 ) );
  nand_x2_sg U1765 ( .A(n795), .B(pwdata[10]), .X(n794) );
  nand_x1_sg U1766 ( .A(n975), .B(n976), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1081 ) );
  nand_x1_sg U1767 ( .A(n971), .B(n972), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1082 ) );
  nand_x1_sg U1768 ( .A(n959), .B(n960), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1085 ) );
  nand_x1_sg U1769 ( .A(n943), .B(n944), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1089 ) );
  nand_x1_sg U1770 ( .A(n939), .B(n940), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1090 ) );
  nand_x1_sg U1771 ( .A(n931), .B(n932), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1092 ) );
  nand_x1_sg U1772 ( .A(n820), .B(n821), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1112 ) );
  nand_x2_sg U1773 ( .A(n822), .B(pwdata[1]), .X(n821) );
  nand_x1_sg U1774 ( .A(n802), .B(n803), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1118 ) );
  nand_x2_sg U1775 ( .A(n804), .B(pwdata[7]), .X(n803) );
  nand_x1_sg U1776 ( .A(n799), .B(n800), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1119 ) );
  nand_x2_sg U1777 ( .A(n801), .B(pwdata[8]), .X(n800) );
  nand_x1_sg U1778 ( .A(n790), .B(n791), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1122 ) );
  nand_x2_sg U1779 ( .A(n792), .B(pwdata[11]), .X(n791) );
  nand_x1_sg U1780 ( .A(n787), .B(n788), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1123 ) );
  nand_x2_sg U1781 ( .A(n789), .B(pwdata[12]), .X(n788) );
  nand_x1_sg U1782 ( .A(n781), .B(n782), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1125 ) );
  nand_x2_sg U1783 ( .A(n783), .B(pwdata[14]), .X(n782) );
  nand_x1_sg U1784 ( .A(n769), .B(n770), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1129 ) );
  nand_x2_sg U1785 ( .A(n771), .B(pwdata[18]), .X(n770) );
  nand_x1_sg U1786 ( .A(n967), .B(n968), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1083 ) );
  nand_x1_sg U1787 ( .A(n947), .B(n948), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1088 ) );
  nand_x1_sg U1788 ( .A(n935), .B(n936), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1091 ) );
  nand_x1_sg U1789 ( .A(n927), .B(n928), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1093 ) );
  nand_x1_sg U1790 ( .A(n907), .B(n908), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1098 ) );
  nand_x1_sg U1791 ( .A(n895), .B(n896), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1101 ) );
  nand_x1_sg U1792 ( .A(n871), .B(n872), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1107 ) );
  nand_x1_sg U1793 ( .A(n814), .B(n815), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1114 ) );
  nand_x2_sg U1794 ( .A(n816), .B(pwdata[3]), .X(n815) );
  nand_x1_sg U1795 ( .A(n796), .B(n797), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1120 ) );
  nand_x2_sg U1796 ( .A(n798), .B(pwdata[9]), .X(n797) );
  nand_x1_sg U1797 ( .A(n784), .B(n785), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1124 ) );
  nand_x2_sg U1798 ( .A(n786), .B(pwdata[13]), .X(n785) );
  nand_x1_sg U1799 ( .A(n778), .B(n779), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1126 ) );
  nand_x2_sg U1800 ( .A(n780), .B(pwdata[15]), .X(n779) );
  nand_x1_sg U1801 ( .A(n760), .B(n761), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1132 ) );
  nand_x2_sg U1802 ( .A(n762), .B(pwdata[21]), .X(n761) );
  nand_x1_sg U1803 ( .A(n742), .B(n743), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1138 ) );
  nand_x2_sg U1804 ( .A(n744), .B(pwdata[27]), .X(n743) );
  nand_x1_sg U1805 ( .A(n526), .B(n527), .X(n1250) );
  nand_x1_sg U1806 ( .A(n678), .B(n679), .X(n1251) );
  nand_x1_sg U1807 ( .A(n963), .B(n964), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1084 ) );
  nand_x1_sg U1808 ( .A(n955), .B(n956), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1086 ) );
  nand_x1_sg U1809 ( .A(n915), .B(n916), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1096 ) );
  nand_x1_sg U1810 ( .A(n903), .B(n904), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1099 ) );
  nand_x1_sg U1811 ( .A(n891), .B(n892), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1102 ) );
  nand_x1_sg U1812 ( .A(n883), .B(n884), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1104 ) );
  nand_x1_sg U1813 ( .A(n867), .B(n868), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1108 ) );
  nand_x1_sg U1814 ( .A(n859), .B(n860), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1110 ) );
  nand_x1_sg U1815 ( .A(n775), .B(n776), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1127 ) );
  nand_x2_sg U1816 ( .A(n777), .B(pwdata[16]), .X(n776) );
  nand_x1_sg U1817 ( .A(n763), .B(n764), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1131 ) );
  nand_x2_sg U1818 ( .A(n765), .B(pwdata[20]), .X(n764) );
  nand_x1_sg U1819 ( .A(n757), .B(n758), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1133 ) );
  nand_x2_sg U1820 ( .A(n759), .B(pwdata[22]), .X(n758) );
  nand_x1_sg U1821 ( .A(n745), .B(n746), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1137 ) );
  nand_x2_sg U1822 ( .A(n747), .B(pwdata[26]), .X(n746) );
  nand_x1_sg U1823 ( .A(n739), .B(n740), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1139 ) );
  nand_x2_sg U1824 ( .A(n741), .B(pwdata[28]), .X(n740) );
  nand_x1_sg U1825 ( .A(n733), .B(n734), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1141 ) );
  nand_x2_sg U1826 ( .A(n735), .B(pwdata[30]), .X(n734) );
  nand_x1_sg U1827 ( .A(n951), .B(n952), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1087 ) );
  nand_x1_sg U1828 ( .A(n923), .B(n924), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1094 ) );
  nand_x1_sg U1829 ( .A(n911), .B(n912), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1097 ) );
  nand_x1_sg U1830 ( .A(n899), .B(n900), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1100 ) );
  nand_x1_sg U1831 ( .A(n887), .B(n888), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1103 ) );
  nand_x1_sg U1832 ( .A(n875), .B(n876), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1106 ) );
  nand_x1_sg U1833 ( .A(n863), .B(n864), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1109 ) );
  nand_x1_sg U1834 ( .A(n854), .B(n855), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1111 ) );
  nand_x1_sg U1835 ( .A(n811), .B(n812), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1115 ) );
  nand_x2_sg U1836 ( .A(n813), .B(pwdata[4]), .X(n812) );
  nand_x1_sg U1837 ( .A(n772), .B(n773), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1128 ) );
  nand_x2_sg U1838 ( .A(n774), .B(pwdata[17]), .X(n773) );
  nand_x1_sg U1839 ( .A(n766), .B(n767), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1130 ) );
  nand_x2_sg U1840 ( .A(n768), .B(pwdata[19]), .X(n767) );
  nand_x1_sg U1841 ( .A(n754), .B(n755), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1134 ) );
  nand_x2_sg U1842 ( .A(n756), .B(pwdata[23]), .X(n755) );
  nand_x1_sg U1843 ( .A(n751), .B(n752), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1135 ) );
  nand_x2_sg U1844 ( .A(n753), .B(pwdata[24]), .X(n752) );
  nand_x1_sg U1845 ( .A(n736), .B(n737), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1140 ) );
  nand_x2_sg U1846 ( .A(n738), .B(pwdata[29]), .X(n737) );
  nand_x1_sg U1847 ( .A(n728), .B(n729), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1142 ) );
  nand_x2_sg U1848 ( .A(n730), .B(pwdata[31]), .X(n729) );
  nor_x1_sg U1849 ( .A(n1132), .B(n1133), .X(n1131) );
  nor_x1_sg U1850 ( .A(n1120), .B(n1121), .X(n1119) );
  nor_x1_sg U1851 ( .A(n1108), .B(n1109), .X(n1107) );
  nor_x1_sg U1852 ( .A(n1095), .B(n1096), .X(n1094) );
  nand_x2_sg U1853 ( .A(n1216), .B(n1217), .X(n1215) );
  nand_x1_sg U1854 ( .A(n919), .B(n920), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1095 ) );
  nand_x2_sg U1855 ( .A(n682), .B(n683), .X(n681) );
  inv_x1_sg U1856 ( .A(n501), .X(prdata[31]) );
  inv_x1_sg U1857 ( .A(n502), .X(prdata[30]) );
  inv_x1_sg U1858 ( .A(n504), .X(prdata[29]) );
  inv_x1_sg U1859 ( .A(n505), .X(prdata[28]) );
  inv_x1_sg U1860 ( .A(n506), .X(prdata[27]) );
  inv_x1_sg U1861 ( .A(n507), .X(prdata[26]) );
  inv_x1_sg U1862 ( .A(n508), .X(prdata[25]) );
  inv_x1_sg U1863 ( .A(n509), .X(prdata[24]) );
  inv_x1_sg U1864 ( .A(n510), .X(prdata[23]) );
  inv_x1_sg U1865 ( .A(n511), .X(prdata[22]) );
  inv_x1_sg U1866 ( .A(n512), .X(prdata[21]) );
  inv_x1_sg U1867 ( .A(n513), .X(prdata[20]) );
  inv_x1_sg U1868 ( .A(n515), .X(prdata[19]) );
  inv_x1_sg U1869 ( .A(n516), .X(prdata[18]) );
  inv_x1_sg U1870 ( .A(n517), .X(prdata[17]) );
  inv_x1_sg U1871 ( .A(n518), .X(prdata[16]) );
  inv_x1_sg U1872 ( .A(n500), .X(prdata[3]) );
  inv_x1_sg U1873 ( .A(n503), .X(prdata[2]) );
  inv_x1_sg U1874 ( .A(n514), .X(prdata[1]) );
  nand_x1_sg U1875 ( .A(n1909), .B(n1198), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1047 ) );
  nand_x1_sg U1876 ( .A(n879), .B(n880), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1105 ) );
  nand_x1_sg U1877 ( .A(n748), .B(n749), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1136 ) );
  nand_x2_sg U1878 ( .A(n750), .B(pwdata[25]), .X(n749) );
  inv_x1_sg U1879 ( .A(\dma_axi64_dual_core/dma_axi64_apb_mux/n4 ), .X(n1520)
         );
  nor_x4_sg U1880 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[2] ), 
        .B(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[3] ), .X(n718)
         );
  nor_x4_sg U1881 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[0] ), 
        .B(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[1] ), .X(n719)
         );
  nor_x4_sg U1882 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[6] ), 
        .B(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[7] ), .X(n716)
         );
  nor_x4_sg U1883 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[4] ), 
        .B(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[5] ), .X(n717)
         );
  inv_x8_sg U1884 ( .A(pwdata[1]), .X(n978) );
  inv_x8_sg U1885 ( .A(pwdata[2]), .X(n974) );
  inv_x8_sg U1886 ( .A(pwdata[3]), .X(n970) );
  inv_x8_sg U1887 ( .A(pwdata[4]), .X(n966) );
  inv_x8_sg U1888 ( .A(pwdata[5]), .X(n962) );
  inv_x8_sg U1889 ( .A(pwdata[6]), .X(n958) );
  inv_x8_sg U1890 ( .A(pwdata[7]), .X(n954) );
  inv_x8_sg U1891 ( .A(pwdata[8]), .X(n950) );
  inv_x8_sg U1892 ( .A(pwdata[9]), .X(n946) );
  inv_x8_sg U1893 ( .A(pwdata[10]), .X(n942) );
  inv_x8_sg U1894 ( .A(pwdata[11]), .X(n938) );
  inv_x8_sg U1895 ( .A(pwdata[12]), .X(n934) );
  inv_x8_sg U1896 ( .A(pwdata[13]), .X(n930) );
  inv_x8_sg U1897 ( .A(pwdata[14]), .X(n926) );
  inv_x8_sg U1898 ( .A(pwdata[15]), .X(n922) );
  inv_x8_sg U1899 ( .A(pwdata[16]), .X(n918) );
  inv_x8_sg U1900 ( .A(pwdata[17]), .X(n914) );
  inv_x8_sg U1901 ( .A(pwdata[18]), .X(n910) );
  inv_x8_sg U1902 ( .A(pwdata[19]), .X(n906) );
  inv_x8_sg U1903 ( .A(pwdata[20]), .X(n902) );
  inv_x8_sg U1904 ( .A(pwdata[21]), .X(n898) );
  inv_x8_sg U1905 ( .A(pwdata[22]), .X(n894) );
  inv_x8_sg U1906 ( .A(pwdata[23]), .X(n890) );
  inv_x8_sg U1907 ( .A(pwdata[24]), .X(n886) );
  inv_x8_sg U1908 ( .A(pwdata[25]), .X(n882) );
  inv_x8_sg U1909 ( .A(pwdata[26]), .X(n878) );
  inv_x8_sg U1910 ( .A(pwdata[27]), .X(n874) );
  inv_x8_sg U1911 ( .A(pwdata[28]), .X(n870) );
  inv_x8_sg U1912 ( .A(pwdata[29]), .X(n866) );
  inv_x8_sg U1913 ( .A(pwdata[30]), .X(n862) );
  inv_x8_sg U1914 ( .A(pwdata[31]), .X(n857) );
  nand_x16_sg U1915 ( .A(psel), .B(pclken), .X(
        \dma_axi64_dual_core/dma_axi64_apb_mux/n4 ) );
  inv_x1_sg U1916 ( .A(n1194), .X(n1521) );
  nand_x1_sg U1917 ( .A(n711), .B(n1507), .X(n1190) );
  nor_x1_sg U1918 ( .A(n692), .B(n1906), .X(n847) );
  nand_x1_sg U1919 ( .A(n726), .B(n1876), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1147 ) );
  nand_x1_sg U1920 ( .A(n564), .B(n565), .X(n563) );
  nand_x4_sg U1921 ( .A(n566), .B(n567), .X(n562) );
  nand_x1_sg U1922 ( .A(n555), .B(n556), .X(n554) );
  nand_x4_sg U1923 ( .A(n557), .B(n558), .X(n553) );
  nand_x1_sg U1924 ( .A(n573), .B(n574), .X(n572) );
  nand_x4_sg U1925 ( .A(n575), .B(n576), .X(n571) );
  nand_x1_sg U1926 ( .A(n609), .B(n610), .X(n608) );
  nand_x4_sg U1927 ( .A(n611), .B(n612), .X(n607) );
  nand_x1_sg U1928 ( .A(n591), .B(n592), .X(n590) );
  nand_x4_sg U1929 ( .A(n593), .B(n594), .X(n589) );
  nand_x1_sg U1930 ( .A(n636), .B(n637), .X(n635) );
  nand_x4_sg U1931 ( .A(n638), .B(n639), .X(n634) );
  nand_x1_sg U1932 ( .A(n533), .B(n534), .X(n532) );
  nand_x4_sg U1933 ( .A(n536), .B(n537), .X(n531) );
  nand_x1_sg U1934 ( .A(n645), .B(n646), .X(n644) );
  nand_x4_sg U1935 ( .A(n647), .B(n648), .X(n643) );
  nand_x1_sg U1936 ( .A(n582), .B(n583), .X(n581) );
  nand_x4_sg U1937 ( .A(n584), .B(n585), .X(n580) );
  nand_x1_sg U1938 ( .A(n618), .B(n619), .X(n617) );
  nand_x4_sg U1939 ( .A(n620), .B(n621), .X(n616) );
  nand_x1_sg U1940 ( .A(n546), .B(n547), .X(n545) );
  nand_x4_sg U1941 ( .A(n548), .B(n549), .X(n544) );
  nand_x1_sg U1942 ( .A(n672), .B(n673), .X(n671) );
  nand_x4_sg U1943 ( .A(n674), .B(n675), .X(n670) );
  nand_x4_sg U1944 ( .A(n663), .B(n664), .X(n662) );
  nand_x4_sg U1945 ( .A(n665), .B(n666), .X(n661) );
  nand_x1_sg U1946 ( .A(n627), .B(n628), .X(n626) );
  nand_x4_sg U1947 ( .A(n629), .B(n630), .X(n625) );
  nand_x1_sg U1948 ( .A(n600), .B(n601), .X(n599) );
  nand_x4_sg U1949 ( .A(n602), .B(n603), .X(n598) );
  nand_x1_sg U1950 ( .A(n654), .B(n655), .X(n653) );
  nand_x4_sg U1951 ( .A(n656), .B(n657), .X(n652) );
  nor_x1_sg U1952 ( .A(n1884), .B(n1014), .X(n1013) );
  nor_x1_sg U1953 ( .A(n1018), .B(n1019), .X(n1012) );
  inv_x1_sg U1954 ( .A(n1017), .X(n1884) );
  nor_x1_sg U1955 ( .A(n1883), .B(n1025), .X(n1024) );
  nor_x1_sg U1956 ( .A(n1029), .B(n1030), .X(n1023) );
  inv_x1_sg U1957 ( .A(n1028), .X(n1883) );
  nor_x1_sg U1958 ( .A(n1882), .B(n1035), .X(n1034) );
  nor_x1_sg U1959 ( .A(n1039), .B(n1040), .X(n1033) );
  inv_x1_sg U1960 ( .A(n1038), .X(n1882) );
  nor_x1_sg U1961 ( .A(n1881), .B(n1045), .X(n1044) );
  nor_x1_sg U1962 ( .A(n1049), .B(n1050), .X(n1043) );
  inv_x1_sg U1963 ( .A(n1048), .X(n1881) );
  nor_x1_sg U1964 ( .A(n1880), .B(n1055), .X(n1054) );
  nor_x1_sg U1965 ( .A(n1059), .B(n1060), .X(n1053) );
  inv_x1_sg U1966 ( .A(n1058), .X(n1880) );
  nor_x1_sg U1967 ( .A(n1879), .B(n1065), .X(n1064) );
  nor_x1_sg U1968 ( .A(n1069), .B(n1070), .X(n1063) );
  inv_x1_sg U1969 ( .A(n1068), .X(n1879) );
  nor_x1_sg U1970 ( .A(n1878), .B(n1075), .X(n1074) );
  nor_x1_sg U1971 ( .A(n1079), .B(n1080), .X(n1073) );
  inv_x1_sg U1972 ( .A(n1078), .X(n1878) );
  nor_x1_sg U1973 ( .A(n1877), .B(n1085), .X(n1084) );
  nor_x1_sg U1974 ( .A(n1089), .B(n1090), .X(n1083) );
  inv_x1_sg U1975 ( .A(n1088), .X(n1877) );
  nor_x1_sg U1976 ( .A(n1102), .B(n1103), .X(n1093) );
  nand_x1_sg U1977 ( .A(n1097), .B(n1098), .X(n1096) );
  nor_x1_sg U1978 ( .A(n1114), .B(n1115), .X(n1106) );
  nand_x1_sg U1979 ( .A(n1110), .B(n1111), .X(n1109) );
  nor_x1_sg U1980 ( .A(n1126), .B(n1127), .X(n1118) );
  nand_x1_sg U1981 ( .A(n1122), .B(n1123), .X(n1121) );
  nor_x1_sg U1982 ( .A(n1138), .B(n1139), .X(n1130) );
  nand_x1_sg U1983 ( .A(n1134), .B(n1135), .X(n1133) );
  nand_x1_sg U1984 ( .A(n1454), .B(n1339), .X(n1101) );
  nand_x1_sg U1985 ( .A(n1451), .B(n1314), .X(n1100) );
  nand_x1_sg U1986 ( .A(n1454), .B(n1340), .X(n1113) );
  nand_x1_sg U1987 ( .A(n1449), .B(n1315), .X(n1112) );
  nand_x1_sg U1988 ( .A(n1453), .B(n1341), .X(n1125) );
  nand_x1_sg U1989 ( .A(n1449), .B(n1316), .X(n1124) );
  nand_x1_sg U1990 ( .A(n1452), .B(n1342), .X(n1137) );
  nand_x1_sg U1991 ( .A(n1451), .B(n1317), .X(n1136) );
  nand_x1_sg U1992 ( .A(n1191), .B(n1192), .X(n1186) );
  nand_x1_sg U1993 ( .A(n1338), .B(n529), .X(n564) );
  nand_x1_sg U1994 ( .A(n1337), .B(n1500), .X(n555) );
  nand_x1_sg U1995 ( .A(n1336), .B(n1496), .X(n573) );
  nand_x1_sg U1996 ( .A(n1335), .B(n1502), .X(n609) );
  nand_x1_sg U1997 ( .A(n1334), .B(n1428), .X(n591) );
  nand_x1_sg U1998 ( .A(n1333), .B(n1501), .X(n636) );
  nand_x1_sg U1999 ( .A(n1332), .B(n1427), .X(n533) );
  nand_x1_sg U2000 ( .A(n1331), .B(n1500), .X(n645) );
  nand_x1_sg U2001 ( .A(n1330), .B(n1496), .X(n582) );
  nand_x1_sg U2002 ( .A(n1329), .B(n1501), .X(n618) );
  nand_x1_sg U2003 ( .A(n1328), .B(n1428), .X(n546) );
  nand_x1_sg U2004 ( .A(n1327), .B(n1427), .X(n672) );
  nand_x1_sg U2005 ( .A(n1326), .B(n1501), .X(n627) );
  nand_x1_sg U2006 ( .A(n1325), .B(n1500), .X(n600) );
  nand_x1_sg U2007 ( .A(n1324), .B(n1502), .X(n654) );
  nand_x1_sg U2008 ( .A(n1453), .B(n1354), .X(n1016) );
  nand_x1_sg U2009 ( .A(n1448), .B(n1343), .X(n1015) );
  nand_x1_sg U2010 ( .A(n1455), .B(n1355), .X(n1027) );
  nand_x1_sg U2011 ( .A(n1449), .B(n1344), .X(n1026) );
  nand_x1_sg U2012 ( .A(n1452), .B(n1356), .X(n1037) );
  nand_x1_sg U2013 ( .A(n1451), .B(n1345), .X(n1036) );
  nand_x1_sg U2014 ( .A(n1452), .B(n1357), .X(n1047) );
  nand_x1_sg U2015 ( .A(n1448), .B(n1346), .X(n1046) );
  nand_x1_sg U2016 ( .A(n1454), .B(n1358), .X(n1057) );
  nand_x1_sg U2017 ( .A(n1449), .B(n1347), .X(n1056) );
  nand_x1_sg U2018 ( .A(n1453), .B(n1359), .X(n1067) );
  nand_x1_sg U2019 ( .A(n1450), .B(n1348), .X(n1066) );
  nand_x1_sg U2020 ( .A(n1452), .B(n1360), .X(n1077) );
  nand_x1_sg U2021 ( .A(n1448), .B(n1349), .X(n1076) );
  nand_x1_sg U2022 ( .A(n1455), .B(n1361), .X(n1087) );
  nand_x1_sg U2023 ( .A(n1450), .B(n1350), .X(n1086) );
  inv_x2_sg U2024 ( .A(n1227), .X(n1909) );
  nor_x1_sg U2025 ( .A(n1181), .B(n1904), .X(n680) );
  nor_x1_sg U2026 ( .A(n705), .B(n1505), .X(n1099) );
  nor_x1_sg U2027 ( .A(n692), .B(n1505), .X(n1177) );
  nor_x1_sg U2028 ( .A(n701), .B(n700), .X(n711) );
  nor_x1_sg U2029 ( .A(n1903), .B(n1181), .X(n1150) );
  inv_x1_sg U2030 ( .A(n726), .X(n1903) );
  nor_x1_sg U2031 ( .A(n1184), .B(n692), .X(n1004) );
  nand_x1_sg U2032 ( .A(n1514), .B(n711), .X(n1184) );
  nor_x1_sg U2033 ( .A(n1182), .B(n724), .X(n726) );
  nand_x1_sg U2034 ( .A(n1005), .B(n1183), .X(n1182) );
  nand_x1_sg U2035 ( .A(n680), .B(n1508), .X(n1193) );
  nor_x1_sg U2036 ( .A(n697), .B(n702), .X(n1221) );
  nor_x1_sg U2037 ( .A(n1183), .B(n1518), .X(n1219) );
  inv_x1_sg U2038 ( .A(n1178), .X(n1906) );
  nor_x1_sg U2039 ( .A(n703), .B(n704), .X(n682) );
  nor_x1_sg U2040 ( .A(n707), .B(n1521), .X(n703) );
  nor_x1_sg U2041 ( .A(n705), .B(n706), .X(n704) );
  nor_x1_sg U2042 ( .A(n1905), .B(n708), .X(n707) );
  nor_x1_sg U2043 ( .A(n684), .B(n685), .X(n683) );
  nor_x1_sg U2044 ( .A(n691), .B(n692), .X(n684) );
  nor_x1_sg U2045 ( .A(n1503), .B(n686), .X(n685) );
  nor_x1_sg U2046 ( .A(n693), .B(n694), .X(n691) );
  inv_x1_sg U2047 ( .A(n1201), .X(n1876) );
  inv_x1_sg U2048 ( .A(\dma_axi64_dual_core/dma_axi64_apb_mux/n4 ), .X(n1902)
         );
  nor_x1_sg U2049 ( .A(n1206), .B(n1207), .X(n1205) );
  nor_x1_sg U2050 ( .A(n1226), .B(n1904), .X(n1204) );
  nand_x1_sg U2051 ( .A(n1208), .B(n1209), .X(n1207) );
  nand_x1_sg U2052 ( .A(n1876), .B(n1210), .X(n1209) );
  nand_x1_sg U2053 ( .A(n702), .B(n705), .X(n1210) );
  nand_x1_sg U2054 ( .A(n1215), .B(n1516), .X(n1208) );
  nor_x1_sg U2055 ( .A(n1220), .B(n1221), .X(n1216) );
  nor_x1_sg U2056 ( .A(n1218), .B(n1219), .X(n1217) );
  nor_x1_sg U2057 ( .A(n1510), .B(n1519), .X(n722) );
  nor_x1_sg U2058 ( .A(n724), .B(n725), .X(n721) );
  nand_x1_sg U2059 ( .A(n720), .B(n1506), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1149 ) );
  nor_x1_sg U2060 ( .A(n1519), .B(n686), .X(n720) );
  nor_x1_sg U2061 ( .A(n568), .B(n569), .X(n566) );
  nor_x1_sg U2062 ( .A(n1313), .B(n1465), .X(n569) );
  nor_x1_sg U2063 ( .A(n1282), .B(n1407), .X(n568) );
  nor_x1_sg U2064 ( .A(n559), .B(n560), .X(n557) );
  nor_x1_sg U2065 ( .A(n1312), .B(n1464), .X(n560) );
  nor_x1_sg U2066 ( .A(n1281), .B(n1458), .X(n559) );
  nor_x1_sg U2067 ( .A(n577), .B(n578), .X(n575) );
  nor_x1_sg U2068 ( .A(n1311), .B(n1463), .X(n578) );
  nor_x1_sg U2069 ( .A(n1280), .B(n1458), .X(n577) );
  nor_x1_sg U2070 ( .A(n613), .B(n614), .X(n611) );
  nor_x1_sg U2071 ( .A(n1310), .B(n1465), .X(n614) );
  nor_x1_sg U2072 ( .A(n1279), .B(n1459), .X(n613) );
  nor_x1_sg U2073 ( .A(n595), .B(n596), .X(n593) );
  nor_x1_sg U2074 ( .A(n1309), .B(n1462), .X(n596) );
  nor_x1_sg U2075 ( .A(n1278), .B(n1458), .X(n595) );
  nor_x1_sg U2076 ( .A(n640), .B(n641), .X(n638) );
  nor_x1_sg U2077 ( .A(n1308), .B(n1462), .X(n641) );
  nor_x1_sg U2078 ( .A(n1277), .B(n1460), .X(n640) );
  nor_x1_sg U2079 ( .A(n539), .B(n540), .X(n536) );
  nor_x1_sg U2080 ( .A(n1307), .B(n1465), .X(n540) );
  nor_x1_sg U2081 ( .A(n1276), .B(n1458), .X(n539) );
  nor_x1_sg U2082 ( .A(n649), .B(n650), .X(n647) );
  nor_x1_sg U2083 ( .A(n1306), .B(n1463), .X(n650) );
  nor_x1_sg U2084 ( .A(n1275), .B(n1460), .X(n649) );
  nor_x1_sg U2085 ( .A(n586), .B(n587), .X(n584) );
  nor_x1_sg U2086 ( .A(n1305), .B(n1464), .X(n587) );
  nor_x1_sg U2087 ( .A(n1274), .B(n1460), .X(n586) );
  nor_x1_sg U2088 ( .A(n622), .B(n623), .X(n620) );
  nor_x1_sg U2089 ( .A(n1304), .B(n1463), .X(n623) );
  nor_x1_sg U2090 ( .A(n1273), .B(n1457), .X(n622) );
  nor_x1_sg U2091 ( .A(n550), .B(n551), .X(n548) );
  nor_x1_sg U2092 ( .A(n1303), .B(n1464), .X(n551) );
  nor_x1_sg U2093 ( .A(n1272), .B(n1459), .X(n550) );
  nor_x1_sg U2094 ( .A(n676), .B(n677), .X(n674) );
  nor_x1_sg U2095 ( .A(n1302), .B(n1463), .X(n677) );
  nor_x1_sg U2096 ( .A(n1271), .B(n1460), .X(n676) );
  nor_x1_sg U2097 ( .A(n667), .B(n668), .X(n665) );
  nor_x1_sg U2098 ( .A(n1301), .B(n1408), .X(n668) );
  nor_x1_sg U2099 ( .A(n1270), .B(n1457), .X(n667) );
  nor_x1_sg U2100 ( .A(n631), .B(n632), .X(n629) );
  nor_x1_sg U2101 ( .A(n1300), .B(n1465), .X(n632) );
  nor_x1_sg U2102 ( .A(n1269), .B(n1459), .X(n631) );
  nor_x1_sg U2103 ( .A(n604), .B(n605), .X(n602) );
  nor_x1_sg U2104 ( .A(n1299), .B(n1462), .X(n605) );
  nor_x1_sg U2105 ( .A(n1268), .B(n1457), .X(n604) );
  nor_x1_sg U2106 ( .A(n658), .B(n659), .X(n656) );
  nor_x1_sg U2107 ( .A(n1298), .B(n1464), .X(n659) );
  nor_x1_sg U2108 ( .A(n1267), .B(n1459), .X(n658) );
  nor_x1_sg U2109 ( .A(pclken), .B(n1373), .X(n1018) );
  nor_x1_sg U2110 ( .A(pclken), .B(n1372), .X(n1029) );
  nor_x1_sg U2111 ( .A(pclken), .B(n1371), .X(n1039) );
  nor_x1_sg U2112 ( .A(pclken), .B(n1370), .X(n1049) );
  nor_x1_sg U2113 ( .A(pclken), .B(n1369), .X(n1059) );
  nor_x1_sg U2114 ( .A(pclken), .B(n1368), .X(n1069) );
  nor_x1_sg U2115 ( .A(pclken), .B(n1367), .X(n1079) );
  nor_x1_sg U2116 ( .A(pclken), .B(n1366), .X(n1089) );
  nor_x1_sg U2117 ( .A(pclken), .B(n1365), .X(n1102) );
  nor_x1_sg U2118 ( .A(pclken), .B(n1364), .X(n1114) );
  nor_x1_sg U2119 ( .A(pclken), .B(n1363), .X(n1126) );
  nor_x1_sg U2120 ( .A(pclken), .B(n1362), .X(n1138) );
  nand_x1_sg U2121 ( .A(n1453), .B(n1318), .X(n1148) );
  nand_x1_sg U2122 ( .A(\dma_axi64_dual_core/core0_clkdiv [2]), .B(n1150), .X(
        n1164) );
  nand_x1_sg U2123 ( .A(n1454), .B(n1319), .X(n1163) );
  nand_x1_sg U2124 ( .A(\dma_axi64_dual_core/core0_clkdiv [1]), .B(n1150), .X(
        n1180) );
  nand_x1_sg U2125 ( .A(n1455), .B(n1320), .X(n1179) );
  nand_x1_sg U2126 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [3]), .B(n1438), .X(n1154) );
  nand_x1_sg U2127 ( .A(n1323), .B(n1497), .X(n1153) );
  nand_x1_sg U2128 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [2]), .B(n1437), .X(n1168) );
  nand_x1_sg U2129 ( .A(n1322), .B(n529), .X(n1167) );
  nand_x1_sg U2130 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [1]), .B(n1482), .X(n1189) );
  nand_x1_sg U2131 ( .A(n1321), .B(n1500), .X(n1188) );
  nand_x1_sg U2132 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[3] ), .B(n1099), .X(n1146) );
  nand_x1_sg U2133 ( .A(n1448), .B(n1351), .X(n1147) );
  nand_x1_sg U2134 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[2] ), .B(n1430), .X(n1161) );
  nand_x1_sg U2135 ( .A(n1450), .B(n1352), .X(n1162) );
  nand_x1_sg U2136 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[1] ), .B(n1430), .X(n1175) );
  nand_x1_sg U2137 ( .A(n1450), .B(n1353), .X(n1176) );
  nand_x1_sg U2138 ( .A(n1479), .B(n1343), .X(n778) );
  nor_x1_sg U2139 ( .A(periph_rx_clr[15]), .B(n1487), .X(n780) );
  nand_x1_sg U2140 ( .A(n1416), .B(n1344), .X(n781) );
  nor_x1_sg U2141 ( .A(periph_rx_clr[14]), .B(n1488), .X(n783) );
  nand_x1_sg U2142 ( .A(n1479), .B(n1345), .X(n784) );
  nor_x1_sg U2143 ( .A(periph_rx_clr[13]), .B(n1490), .X(n786) );
  nand_x1_sg U2144 ( .A(n1416), .B(n1346), .X(n787) );
  nor_x1_sg U2145 ( .A(periph_rx_clr[12]), .B(n1422), .X(n789) );
  nand_x1_sg U2146 ( .A(n1477), .B(n1347), .X(n790) );
  nor_x1_sg U2147 ( .A(periph_rx_clr[11]), .B(n1440), .X(n792) );
  nand_x1_sg U2148 ( .A(n1416), .B(n1348), .X(n793) );
  nor_x1_sg U2149 ( .A(periph_rx_clr[10]), .B(n1422), .X(n795) );
  nand_x1_sg U2150 ( .A(n1478), .B(n1349), .X(n796) );
  nor_x1_sg U2151 ( .A(periph_rx_clr[9]), .B(n1487), .X(n798) );
  nand_x1_sg U2152 ( .A(n1436), .B(n1350), .X(n799) );
  nor_x1_sg U2153 ( .A(periph_rx_clr[8]), .B(n1440), .X(n801) );
  nand_x1_sg U2154 ( .A(n1479), .B(n1314), .X(n802) );
  nor_x1_sg U2155 ( .A(periph_rx_clr[7]), .B(n1422), .X(n804) );
  nand_x1_sg U2156 ( .A(n1417), .B(n1315), .X(n805) );
  nor_x1_sg U2157 ( .A(periph_rx_clr[6]), .B(n1489), .X(n807) );
  nand_x1_sg U2158 ( .A(n1477), .B(n1316), .X(n808) );
  nor_x1_sg U2159 ( .A(periph_rx_clr[5]), .B(n1423), .X(n810) );
  nand_x1_sg U2160 ( .A(n1416), .B(n1317), .X(n811) );
  nor_x1_sg U2161 ( .A(periph_rx_clr[4]), .B(n1489), .X(n813) );
  nand_x1_sg U2162 ( .A(n1479), .B(n1351), .X(n814) );
  nor_x1_sg U2163 ( .A(periph_rx_clr[3]), .B(n1487), .X(n816) );
  nand_x1_sg U2164 ( .A(n1435), .B(n1352), .X(n817) );
  nor_x1_sg U2165 ( .A(periph_rx_clr[2]), .B(n1490), .X(n819) );
  nand_x1_sg U2166 ( .A(n1436), .B(n1353), .X(n820) );
  nor_x1_sg U2167 ( .A(periph_rx_clr[1]), .B(n1490), .X(n822) );
  nand_x1_sg U2168 ( .A(n921), .B(n1426), .X(n920) );
  nand_x1_sg U2169 ( .A(n1474), .B(n1354), .X(n919) );
  nor_x1_sg U2170 ( .A(periph_tx_clr[15]), .B(n922), .X(n921) );
  nand_x1_sg U2171 ( .A(n925), .B(n1426), .X(n924) );
  nand_x1_sg U2172 ( .A(n1413), .B(n1355), .X(n923) );
  nor_x1_sg U2173 ( .A(periph_tx_clr[14]), .B(n926), .X(n925) );
  nand_x1_sg U2174 ( .A(n929), .B(n1425), .X(n928) );
  nand_x1_sg U2175 ( .A(n1474), .B(n1356), .X(n927) );
  nor_x1_sg U2176 ( .A(periph_tx_clr[13]), .B(n930), .X(n929) );
  nand_x1_sg U2177 ( .A(n933), .B(n1494), .X(n932) );
  nand_x1_sg U2178 ( .A(n1413), .B(n1357), .X(n931) );
  nor_x1_sg U2179 ( .A(periph_tx_clr[12]), .B(n934), .X(n933) );
  nand_x1_sg U2180 ( .A(n937), .B(n1426), .X(n936) );
  nand_x1_sg U2181 ( .A(n1472), .B(n1358), .X(n935) );
  nor_x1_sg U2182 ( .A(periph_tx_clr[11]), .B(n938), .X(n937) );
  nand_x1_sg U2183 ( .A(n941), .B(n1492), .X(n940) );
  nand_x1_sg U2184 ( .A(n1413), .B(n1359), .X(n939) );
  nor_x1_sg U2185 ( .A(periph_tx_clr[10]), .B(n942), .X(n941) );
  nand_x1_sg U2186 ( .A(n945), .B(n1442), .X(n944) );
  nand_x1_sg U2187 ( .A(n1473), .B(n1360), .X(n943) );
  nor_x1_sg U2188 ( .A(periph_tx_clr[9]), .B(n946), .X(n945) );
  nand_x1_sg U2189 ( .A(n949), .B(n1492), .X(n948) );
  nand_x1_sg U2190 ( .A(n1434), .B(n1361), .X(n947) );
  nor_x1_sg U2191 ( .A(periph_tx_clr[8]), .B(n950), .X(n949) );
  nand_x1_sg U2192 ( .A(n953), .B(n1426), .X(n952) );
  nand_x1_sg U2193 ( .A(n1474), .B(n1339), .X(n951) );
  nor_x1_sg U2194 ( .A(periph_tx_clr[7]), .B(n954), .X(n953) );
  nand_x1_sg U2195 ( .A(n957), .B(n1493), .X(n956) );
  nand_x1_sg U2196 ( .A(n1414), .B(n1340), .X(n955) );
  nor_x1_sg U2197 ( .A(periph_tx_clr[6]), .B(n958), .X(n957) );
  nand_x1_sg U2198 ( .A(n961), .B(n1425), .X(n960) );
  nand_x1_sg U2199 ( .A(n1472), .B(n1341), .X(n959) );
  nor_x1_sg U2200 ( .A(periph_tx_clr[5]), .B(n962), .X(n961) );
  nand_x1_sg U2201 ( .A(n965), .B(n1492), .X(n964) );
  nand_x1_sg U2202 ( .A(n1413), .B(n1342), .X(n963) );
  nor_x1_sg U2203 ( .A(periph_tx_clr[4]), .B(n966), .X(n965) );
  nand_x1_sg U2204 ( .A(n969), .B(n1495), .X(n968) );
  nand_x1_sg U2205 ( .A(n1474), .B(n1318), .X(n967) );
  nor_x1_sg U2206 ( .A(periph_tx_clr[3]), .B(n970), .X(n969) );
  nand_x1_sg U2207 ( .A(n973), .B(n1493), .X(n972) );
  nand_x1_sg U2208 ( .A(n1433), .B(n1319), .X(n971) );
  nor_x1_sg U2209 ( .A(periph_tx_clr[2]), .B(n974), .X(n973) );
  nand_x1_sg U2210 ( .A(n977), .B(n1495), .X(n976) );
  nand_x1_sg U2211 ( .A(n1434), .B(n1320), .X(n975) );
  nor_x1_sg U2212 ( .A(periph_tx_clr[1]), .B(n978), .X(n977) );
  nand_x1_sg U2213 ( .A(n1435), .B(n1375), .X(n728) );
  nor_x1_sg U2214 ( .A(periph_rx_clr[31]), .B(n1440), .X(n730) );
  nand_x1_sg U2215 ( .A(n1477), .B(n1376), .X(n733) );
  nor_x1_sg U2216 ( .A(periph_rx_clr[30]), .B(n1489), .X(n735) );
  nand_x1_sg U2217 ( .A(n1480), .B(n1377), .X(n736) );
  nor_x1_sg U2218 ( .A(periph_rx_clr[29]), .B(n1488), .X(n738) );
  nand_x1_sg U2219 ( .A(n1480), .B(n1378), .X(n739) );
  nor_x1_sg U2220 ( .A(periph_rx_clr[28]), .B(n1439), .X(n741) );
  nand_x1_sg U2221 ( .A(n1478), .B(n1379), .X(n742) );
  nor_x1_sg U2222 ( .A(periph_rx_clr[27]), .B(n1488), .X(n744) );
  nand_x1_sg U2223 ( .A(n1480), .B(n1380), .X(n745) );
  nor_x1_sg U2224 ( .A(periph_rx_clr[26]), .B(n1487), .X(n747) );
  nand_x1_sg U2225 ( .A(n1478), .B(n1381), .X(n748) );
  nor_x1_sg U2226 ( .A(periph_rx_clr[25]), .B(n1439), .X(n750) );
  nand_x1_sg U2227 ( .A(n1436), .B(n1382), .X(n751) );
  nor_x1_sg U2228 ( .A(periph_rx_clr[24]), .B(n1440), .X(n753) );
  nand_x1_sg U2229 ( .A(n1436), .B(n1383), .X(n754) );
  nor_x1_sg U2230 ( .A(periph_rx_clr[23]), .B(n1422), .X(n756) );
  nand_x1_sg U2231 ( .A(n1435), .B(n1384), .X(n757) );
  nor_x1_sg U2232 ( .A(periph_rx_clr[22]), .B(n1488), .X(n759) );
  nand_x1_sg U2233 ( .A(n1480), .B(n1385), .X(n760) );
  nor_x1_sg U2234 ( .A(periph_rx_clr[21]), .B(n1439), .X(n762) );
  nand_x1_sg U2235 ( .A(n1478), .B(n1386), .X(n763) );
  nor_x1_sg U2236 ( .A(periph_rx_clr[20]), .B(n1489), .X(n765) );
  nand_x1_sg U2237 ( .A(n1477), .B(n1387), .X(n766) );
  nor_x1_sg U2238 ( .A(periph_rx_clr[19]), .B(n1490), .X(n768) );
  nand_x1_sg U2239 ( .A(n1417), .B(n1403), .X(n769) );
  nor_x1_sg U2240 ( .A(periph_rx_clr[18]), .B(n1423), .X(n771) );
  nand_x1_sg U2241 ( .A(n1417), .B(n1404), .X(n772) );
  nor_x1_sg U2242 ( .A(periph_rx_clr[17]), .B(n1439), .X(n774) );
  nand_x1_sg U2243 ( .A(n1435), .B(n1388), .X(n775) );
  nor_x1_sg U2244 ( .A(periph_rx_clr[16]), .B(n1423), .X(n777) );
  nand_x1_sg U2245 ( .A(n856), .B(n1493), .X(n855) );
  nand_x1_sg U2246 ( .A(n1433), .B(n1389), .X(n854) );
  nor_x1_sg U2247 ( .A(periph_tx_clr[31]), .B(n857), .X(n856) );
  nand_x1_sg U2248 ( .A(n1472), .B(n1390), .X(n859) );
  nor_x1_sg U2249 ( .A(periph_tx_clr[30]), .B(n862), .X(n861) );
  nand_x1_sg U2250 ( .A(n865), .B(n1442), .X(n864) );
  nand_x1_sg U2251 ( .A(n1475), .B(n1391), .X(n863) );
  nor_x1_sg U2252 ( .A(periph_tx_clr[29]), .B(n866), .X(n865) );
  nand_x1_sg U2253 ( .A(n1475), .B(n1392), .X(n867) );
  nor_x1_sg U2254 ( .A(periph_tx_clr[28]), .B(n870), .X(n869) );
  nand_x1_sg U2255 ( .A(n873), .B(n1441), .X(n872) );
  nand_x1_sg U2256 ( .A(n1473), .B(n1393), .X(n871) );
  nor_x1_sg U2257 ( .A(periph_tx_clr[27]), .B(n874), .X(n873) );
  nand_x1_sg U2258 ( .A(n877), .B(n1492), .X(n876) );
  nand_x1_sg U2259 ( .A(n1475), .B(n1394), .X(n875) );
  nor_x1_sg U2260 ( .A(periph_tx_clr[26]), .B(n878), .X(n877) );
  nand_x1_sg U2261 ( .A(n881), .B(n1494), .X(n880) );
  nand_x1_sg U2262 ( .A(n1473), .B(n1395), .X(n879) );
  nor_x1_sg U2263 ( .A(periph_tx_clr[25]), .B(n882), .X(n881) );
  nand_x1_sg U2264 ( .A(n1434), .B(n1396), .X(n883) );
  nor_x1_sg U2265 ( .A(periph_tx_clr[24]), .B(n886), .X(n885) );
  nand_x1_sg U2266 ( .A(n889), .B(n1425), .X(n888) );
  nand_x1_sg U2267 ( .A(n1434), .B(n1397), .X(n887) );
  nor_x1_sg U2268 ( .A(periph_tx_clr[23]), .B(n890), .X(n889) );
  nand_x1_sg U2269 ( .A(n893), .B(n1495), .X(n892) );
  nand_x1_sg U2270 ( .A(n1433), .B(n1398), .X(n891) );
  nor_x1_sg U2271 ( .A(periph_tx_clr[22]), .B(n894), .X(n893) );
  nand_x1_sg U2272 ( .A(n897), .B(n1494), .X(n896) );
  nand_x1_sg U2273 ( .A(n1475), .B(n1399), .X(n895) );
  nor_x1_sg U2274 ( .A(periph_tx_clr[21]), .B(n898), .X(n897) );
  nand_x1_sg U2275 ( .A(n901), .B(n1494), .X(n900) );
  nand_x1_sg U2276 ( .A(n1473), .B(n1400), .X(n899) );
  nor_x1_sg U2277 ( .A(periph_tx_clr[20]), .B(n902), .X(n901) );
  nand_x1_sg U2278 ( .A(n905), .B(n1441), .X(n904) );
  nand_x1_sg U2279 ( .A(n1472), .B(n1401), .X(n903) );
  nor_x1_sg U2280 ( .A(periph_tx_clr[19]), .B(n906), .X(n905) );
  nand_x1_sg U2281 ( .A(n909), .B(n1493), .X(n908) );
  nand_x1_sg U2282 ( .A(n1414), .B(n1405), .X(n907) );
  nor_x1_sg U2283 ( .A(periph_tx_clr[18]), .B(n910), .X(n909) );
  nand_x1_sg U2284 ( .A(n913), .B(n1425), .X(n912) );
  nand_x1_sg U2285 ( .A(n1414), .B(n1406), .X(n911) );
  nor_x1_sg U2286 ( .A(periph_tx_clr[17]), .B(n914), .X(n913) );
  nand_x1_sg U2287 ( .A(n917), .B(n1441), .X(n916) );
  nand_x1_sg U2288 ( .A(n1433), .B(n1402), .X(n915) );
  nor_x1_sg U2289 ( .A(periph_tx_clr[16]), .B(n918), .X(n917) );
  nand_x1_sg U2290 ( .A(n1507), .B(n681), .X(n679) );
  nand_x1_sg U2291 ( .A(n1902), .B(n528), .X(n527) );
  inv_x2_sg U2292 ( .A(penable), .X(n528) );
  nor_x1_sg U2293 ( .A(n1321), .B(\dma_axi64_dual_core/prdata0 [1]), .X(n514)
         );
  nor_x1_sg U2294 ( .A(n1322), .B(\dma_axi64_dual_core/prdata0 [2]), .X(n503)
         );
  nor_x1_sg U2295 ( .A(n1323), .B(\dma_axi64_dual_core/prdata0 [3]), .X(n500)
         );
  nor_x1_sg U2296 ( .A(n1324), .B(\dma_axi64_dual_core/prdata0 [16]), .X(n518)
         );
  nor_x1_sg U2297 ( .A(n1325), .B(\dma_axi64_dual_core/prdata0 [17]), .X(n517)
         );
  nor_x1_sg U2298 ( .A(n1326), .B(\dma_axi64_dual_core/prdata0 [18]), .X(n516)
         );
  nor_x1_sg U2299 ( .A(n1374), .B(\dma_axi64_dual_core/prdata0 [19]), .X(n515)
         );
  nor_x1_sg U2300 ( .A(n1327), .B(\dma_axi64_dual_core/prdata0 [20]), .X(n513)
         );
  nor_x1_sg U2301 ( .A(n1328), .B(\dma_axi64_dual_core/prdata0 [21]), .X(n512)
         );
  nor_x1_sg U2302 ( .A(n1329), .B(\dma_axi64_dual_core/prdata0 [22]), .X(n511)
         );
  nor_x1_sg U2303 ( .A(n1330), .B(\dma_axi64_dual_core/prdata0 [23]), .X(n510)
         );
  nor_x1_sg U2304 ( .A(n1331), .B(\dma_axi64_dual_core/prdata0 [24]), .X(n509)
         );
  nor_x1_sg U2305 ( .A(n1332), .B(\dma_axi64_dual_core/prdata0 [25]), .X(n508)
         );
  nor_x1_sg U2306 ( .A(n1333), .B(\dma_axi64_dual_core/prdata0 [26]), .X(n507)
         );
  nor_x1_sg U2307 ( .A(n1334), .B(\dma_axi64_dual_core/prdata0 [27]), .X(n506)
         );
  nor_x1_sg U2308 ( .A(n1335), .B(\dma_axi64_dual_core/prdata0 [28]), .X(n505)
         );
  nor_x1_sg U2309 ( .A(n1336), .B(\dma_axi64_dual_core/prdata0 [29]), .X(n504)
         );
  nor_x1_sg U2310 ( .A(n1337), .B(\dma_axi64_dual_core/prdata0 [30]), .X(n502)
         );
  nor_x1_sg U2311 ( .A(n1338), .B(\dma_axi64_dual_core/prdata0 [31]), .X(n501)
         );
  nand_x1_sg U2312 ( .A(n499), .B(n1362), .X(prdata[4]) );
  inv_x2_sg U2313 ( .A(\dma_axi64_dual_core/prdata0 [4]), .X(n499) );
  nand_x1_sg U2314 ( .A(n498), .B(n1363), .X(prdata[5]) );
  inv_x2_sg U2315 ( .A(\dma_axi64_dual_core/prdata0 [5]), .X(n498) );
  nand_x1_sg U2316 ( .A(n497), .B(n1364), .X(prdata[6]) );
  inv_x2_sg U2317 ( .A(\dma_axi64_dual_core/prdata0 [6]), .X(n497) );
  nand_x1_sg U2318 ( .A(n496), .B(n1365), .X(prdata[7]) );
  inv_x2_sg U2319 ( .A(\dma_axi64_dual_core/prdata0 [7]), .X(n496) );
  nand_x1_sg U2320 ( .A(n495), .B(n1366), .X(prdata[8]) );
  inv_x2_sg U2321 ( .A(\dma_axi64_dual_core/prdata0 [8]), .X(n495) );
  nand_x1_sg U2322 ( .A(n494), .B(n1367), .X(prdata[9]) );
  inv_x2_sg U2323 ( .A(\dma_axi64_dual_core/prdata0 [9]), .X(n494) );
  nand_x1_sg U2324 ( .A(n524), .B(n1368), .X(prdata[10]) );
  inv_x2_sg U2325 ( .A(\dma_axi64_dual_core/prdata0 [10]), .X(n524) );
  nand_x1_sg U2326 ( .A(n523), .B(n1369), .X(prdata[11]) );
  inv_x2_sg U2327 ( .A(\dma_axi64_dual_core/prdata0 [11]), .X(n523) );
  nand_x1_sg U2328 ( .A(n522), .B(n1370), .X(prdata[12]) );
  inv_x2_sg U2329 ( .A(\dma_axi64_dual_core/prdata0 [12]), .X(n522) );
  nand_x1_sg U2330 ( .A(n521), .B(n1371), .X(prdata[13]) );
  inv_x2_sg U2331 ( .A(\dma_axi64_dual_core/prdata0 [13]), .X(n521) );
  nand_x1_sg U2332 ( .A(n520), .B(n1372), .X(prdata[14]) );
  inv_x2_sg U2333 ( .A(\dma_axi64_dual_core/prdata0 [14]), .X(n520) );
  nand_x1_sg U2334 ( .A(n519), .B(n1373), .X(prdata[15]) );
  inv_x2_sg U2335 ( .A(\dma_axi64_dual_core/prdata0 [15]), .X(n519) );
  nor_x1_sg U2336 ( .A(n1509), .B(paddr[2]), .X(n697) );
  inv_x1_sg U2337 ( .A(n1513), .X(n1907) );
  nand_x1_sg U2338 ( .A(n680), .B(paddr[3]), .X(n1196) );
  nor_x1_sg U2339 ( .A(paddr[6]), .B(n1906), .X(n1197) );
  inv_x1_sg U2340 ( .A(n724), .X(n1908) );
  inv_x1_sg U2341 ( .A(n1203), .X(n1901) );
  nor_x1_sg U2342 ( .A(n1495), .B(periph_tx_clr[10]), .X(n1002) );
  nor_x1_sg U2343 ( .A(paddr[3]), .B(n702), .X(n1225) );
  nor_x1_sg U2344 ( .A(n1222), .B(n1516), .X(n1206) );
  nor_x1_sg U2345 ( .A(n1223), .B(n1224), .X(n1222) );
  nor_x1_sg U2346 ( .A(n1225), .B(n1510), .X(n1223) );
  nor_x1_sg U2347 ( .A(paddr[6]), .B(n1178), .X(n1224) );
  nand_x1_sg U2348 ( .A(\dma_axi64_dual_core/core0_clkdiv [0]), .B(n700), .X(
        n699) );
  nand_x1_sg U2349 ( .A(n1518), .B(n1514), .X(n698) );
  nor_x1_sg U2350 ( .A(n695), .B(n696), .X(n694) );
  nand_x1_sg U2351 ( .A(paddr[7]), .B(n1508), .X(n696) );
  nor_x1_sg U2352 ( .A(paddr[4]), .B(n700), .X(n1226) );
  nor_x1_sg U2353 ( .A(n1498), .B(periph_rx_clr[10]), .X(n846) );
  nor_x1_sg U2354 ( .A(penable), .B(n1203), .X(n1214) );
  nand_x1_sg U2355 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[7] ), .B(n1430), .X(n1098) );
  nand_x1_sg U2356 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[6] ), .B(n1099), .X(n1111) );
  nand_x1_sg U2357 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[5] ), .B(n1099), .X(n1123) );
  nand_x1_sg U2358 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[4] ), .B(n1430), .X(n1135) );
  nand_x1_sg U2359 ( .A(\dma_axi64_dual_core/rd_prio_top_num0 [1]), .B(n1445), 
        .X(n1191) );
  nand_x1_sg U2360 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [0]), .B(n711), .X(n710) );
  nand_x1_sg U2361 ( .A(\dma_axi64_dual_core/wr_prio_high_num0 [0]), .B(n1447), 
        .X(n1052) );
  nand_x1_sg U2362 ( .A(\dma_axi64_dual_core/wr_prio_top0 ), .B(n1445), .X(
        n1062) );
  nand_x1_sg U2363 ( .A(\dma_axi64_dual_core/wr_prio_top_num0 [2]), .B(n1444), 
        .X(n1072) );
  nand_x1_sg U2364 ( .A(\dma_axi64_dual_core/wr_prio_top_num0 [1]), .B(n1446), 
        .X(n1082) );
  nand_x1_sg U2365 ( .A(\dma_axi64_dual_core/wr_prio_top_num0 [0]), .B(n1446), 
        .X(n1092) );
  nand_x1_sg U2366 ( .A(\dma_axi64_dual_core/rd_prio_high0 ), .B(n1444), .X(
        n1105) );
  nand_x1_sg U2367 ( .A(\dma_axi64_dual_core/rd_prio_high_num0 [2]), .B(n1446), 
        .X(n1117) );
  nand_x1_sg U2368 ( .A(\dma_axi64_dual_core/rd_prio_high_num0 [1]), .B(n1447), 
        .X(n1129) );
  nand_x1_sg U2369 ( .A(\dma_axi64_dual_core/rd_prio_high_num0 [0]), .B(n1445), 
        .X(n1141) );
  nand_x1_sg U2370 ( .A(\dma_axi64_dual_core/wr_prio_high0 ), .B(n1445), .X(
        n1021) );
  nand_x1_sg U2371 ( .A(\dma_axi64_dual_core/wr_prio_high_num0 [2]), .B(n1446), 
        .X(n1032) );
  nand_x1_sg U2372 ( .A(\dma_axi64_dual_core/wr_prio_high_num0 [1]), .B(n1447), 
        .X(n1042) );
  nand_x1_sg U2373 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [31]), .B(n1485), 
        .X(n565) );
  nand_x1_sg U2374 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [30]), .B(n1484), 
        .X(n556) );
  nand_x1_sg U2375 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [29]), .B(n1483), 
        .X(n574) );
  nand_x1_sg U2376 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [28]), .B(n1419), 
        .X(n610) );
  nand_x1_sg U2377 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [7]), .B(n1468), .X(n1097) );
  nand_x1_sg U2378 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [6]), .B(n1410), .X(n1110) );
  nand_x1_sg U2379 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [5]), .B(n1467), .X(n1122) );
  nand_x1_sg U2380 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [3]), .B(n1470), .X(n1156) );
  nor_x1_sg U2381 ( .A(paddr[12]), .B(
        \dma_axi64_dual_core/dma_axi64_apb_mux/n4 ), .X(n1229) );
  nand_x1_sg U2382 ( .A(n727), .B(n1506), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1146 ) );
  nor_x1_sg U2383 ( .A(paddr[3]), .B(n686), .X(n727) );
endmodule

