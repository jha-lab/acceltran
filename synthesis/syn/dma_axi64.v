
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
  wire   \dma_axi64_dual_core/n62 , \dma_axi64_dual_core/n61 ,
         \dma_axi64_dual_core/n60 , \dma_axi64_dual_core/n59 ,
         \dma_axi64_dual_core/n58 , \dma_axi64_dual_core/n57 ,
         \dma_axi64_dual_core/n56 , \dma_axi64_dual_core/n55 ,
         \dma_axi64_dual_core/n54 , \dma_axi64_dual_core/n53 ,
         \dma_axi64_dual_core/n52 , \dma_axi64_dual_core/n51 ,
         \dma_axi64_dual_core/n50 , \dma_axi64_dual_core/n49 ,
         \dma_axi64_dual_core/n48 , \dma_axi64_dual_core/n47 ,
         \dma_axi64_dual_core/n46 , \dma_axi64_dual_core/n45 ,
         \dma_axi64_dual_core/n44 , \dma_axi64_dual_core/n43 ,
         \dma_axi64_dual_core/n42 , \dma_axi64_dual_core/n41 ,
         \dma_axi64_dual_core/n40 , \dma_axi64_dual_core/n39 ,
         \dma_axi64_dual_core/n38 , \dma_axi64_dual_core/n37 ,
         \dma_axi64_dual_core/n36 , \dma_axi64_dual_core/n35 ,
         \dma_axi64_dual_core/n34 , \dma_axi64_dual_core/n33 ,
         \dma_axi64_dual_core/n32 , \dma_axi64_dual_core/n31 ,
         \dma_axi64_dual_core/n30 , \dma_axi64_dual_core/n29 ,
         \dma_axi64_dual_core/n28 , \dma_axi64_dual_core/n27 ,
         \dma_axi64_dual_core/n26 , \dma_axi64_dual_core/n25 ,
         \dma_axi64_dual_core/n24 , \dma_axi64_dual_core/n23 ,
         \dma_axi64_dual_core/n22 , \dma_axi64_dual_core/n21 ,
         \dma_axi64_dual_core/n20 , \dma_axi64_dual_core/n19 ,
         \dma_axi64_dual_core/n18 , \dma_axi64_dual_core/n17 ,
         \dma_axi64_dual_core/n16 , \dma_axi64_dual_core/n15 ,
         \dma_axi64_dual_core/n14 , \dma_axi64_dual_core/n13 ,
         \dma_axi64_dual_core/n12 , \dma_axi64_dual_core/n11 ,
         \dma_axi64_dual_core/n10 , \dma_axi64_dual_core/n9 ,
         \dma_axi64_dual_core/n8 , \dma_axi64_dual_core/n7 ,
         \dma_axi64_dual_core/n6 , \dma_axi64_dual_core/n5 ,
         \dma_axi64_dual_core/n4 , \dma_axi64_dual_core/n3 ,
         \dma_axi64_dual_core/n2 , \dma_axi64_dual_core/n1 ,
         \dma_axi64_dual_core/pslverr_reg ,
         \dma_axi64_dual_core/dma_axi64_apb_mux/n8 ,
         \dma_axi64_dual_core/dma_axi64_apb_mux/n3 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1411 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1347 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1346 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1345 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1344 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1343 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1342 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1341 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1340 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1339 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1338 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1337 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1336 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1335 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1334 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1333 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1332 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1331 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1330 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1329 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1328 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1327 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1326 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1325 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1324 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1323 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1322 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1321 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1320 ,
         \dma_axi64_dual_core/dma_axi64_reg/n1316 ,
         \dma_axi64_dual_core/dma_axi64_reg/N405 ,
         \dma_axi64_dual_core/dma_axi64_reg/N397 ,
         \dma_axi64_dual_core/dma_axi64_reg/N388 ,
         \dma_axi64_dual_core/dma_axi64_reg/N380 , n367, n368, n369, n370,
         n371, n372, n373, n374, n375, n376, n377, n378, n379, n380, n381,
         n382, n383, n384, n385, n386, n387, n388, n389, n390, n391, n392,
         n393, n394, n395, n396, n397, n398, n399, n400, n401, n402, n403,
         n404, n405, n406, n407, n408, n409, n410, n411, n412, n413, n414,
         n415, n416, n417, n418, n419, n420, n421, n422, n423, n424, n425,
         n426, n427, n428, n429, n430, n431, n432, n433, n434, n435, n436,
         n437, n438, n439, n440, n441, n442, n443, n444, n445, n446, n447,
         n448, n449, n450, n451, n452, n453, n454, n455, n456, n457, n458,
         n459, n460, n461, n462, n463, n464, n465, n466, n467, n468, n469,
         n470, n471, n472, n473, n474, n475, n476, n477, n478, n479, n480,
         n481, n482, n483, n484, n485, n486, n487, n488, n489, n490, n491,
         n492, n493, n494, n495, n496, n497, n498, n499, n500, n501, n502,
         n503, n504, n505, n506, n507, n508, n509, n510, n511, n512, n513,
         n514, n515, n516, n517, n518, n519, n520, n521, n522, n523, n524,
         n525, n526, n527, n528, n529, n530, n531, n532, n533, n534, n535,
         n536, n537, n538, n539, n540, n541, n542, n543, n544, n545, n546,
         n547, n548, n549, n550, n551, n552, n553, n554, n555, n556, n557,
         n558, n559, n560, n561, n562, n563, n564, n565, n566, n567, n568,
         n569, n570, n571, n572, n573, n574, n575, n576, n577, n578, n579,
         n580, n581, n582, n583, n584, n585, n586, n587, n588, n589, n590,
         n591, n592, n593, n594, n595, n596, n597, n598, n599, n600, n601,
         n602, n603, n604, n605, n606, n607, n608, n609, n610, n611, n612,
         n613, n614, n615, n616, n617, n618, n619, n620, n621, n622, n623,
         n624, n625, n626, n627, n628, n629, n630, n631, n632, n633, n634,
         n635, n636, n637, n638, n639, n640, n641, n642, n643, n644, n645,
         n646, n647, n648, n649, n650, n651, n652, n653, n654, n655, n656,
         n657, n658, n659, n660, n661, n662, n663, n664, n665, n666, n667,
         n668, n669, n670, n671, n672, n673, n674, n675, n676, n677, n678,
         n679, n680, n681, n682, n683, n684, n685, n686, n687, n688, n689,
         n690, n691, n692, n693, n694, n695, n696, n697, n698, n699, n700,
         n701, n702, n703, n704, n705, n706, n707, n708, n709, n710, n711,
         n712, n713, n714, n715, n716, n717, n718, n719, n720, n721, n722,
         n723, n724, n725, n726, n727, n728, n729, n730, n731, n732, n733,
         n734, n735, n736, n737, n738, n739, n740, n741, n742, n743, n744,
         n745, n746, n747, n748, n749, n750, n751, n752, n753, n754, n755,
         n756, n757, n758, n759, n760, n761, n762, n763, n764, n765, n766,
         n767, n768, n769, n770, n771, n772, n773, n774, n775, n776, n777,
         n778, n779, n780, n781, n782, n783, n784, n785, n786, n787, n788,
         n789, n790, n791, n792, n793, n794, n795, n796, n797, n798, n799,
         n800, n801, n802, n803, n804, n805, n806, n807, n808, n809, n810,
         n811, n812, n813, n814, n815, n816, n817, n818, n819, n820, n821,
         n822, n823, n824, n825, n826, n827, n828, n829, n830, n831, n832,
         n833, n834, n835, n836, n837, n838, n839, n840, n841, n842, n843,
         n844, n845, n846, n847, n848, n849, n850, n851, n852, n853, n854,
         n855, n856, n857, n858, n859, n860, n861, n862, n863, n864, n865,
         n866, n867, n868, n869, n870, n871, n872, n873, n874, n875, n876,
         n877, n878, n879, n880, n881, n882, n883, n884, n885, n886, n887,
         n888, n889, n890, n891, n892, n893, n894, n895, n896, n897, n898,
         n899, n900, n901, n902, n903, n904, n905, n906, n907, n908, n909,
         n910, n911, n912, n913, n914, n915, n916, n917, n918, n919, n920,
         n921, n922, n923, n924, n925, n926, n927, n928, n929, n930, n931,
         n932, n933, n934, n935, n936, n937, n938, n939, n940, n941, n942,
         n943, n944, n945, n946, n947, n948, n949, n950, n951, n952, n953,
         n954, n955, n956, n957, n958, n959, n960, n961, n962, n963, n964,
         n965, n966, n967, n968, n969, n970, n971, n972, n973, n974, n975,
         n976, n977, n978, n979, n980, n981, n982, n983, n984, n985, n986,
         n987, n988, n989, n990, n991, n992, n993, n994, n995, n996, n997,
         n998, n999, n1000, n1001, n1002, n1003, n1004, n1005, n1006, n1007,
         n1008, n1009, n1010, n1011, n1012, n1013, n1014, n1015, n1016, n1017,
         n1018, n1019, n1020, n1021, n1022, n1023, n1024, n1025, n1026, n1027,
         n1028, n1029, n1030, n1031, n1032, n1033, n1034, n1035, n1036, n1037,
         n1038, n1039, n1040, n1041, n1042, n1043, n1044, n1045, n1046, n1047,
         n1048, n1049, n1050, n1051, n1052, n1053, n1054, n1055, n1056, n1057,
         n1058, n1059, n1060, n1061, n1062, n1063, n1064, n1065, n1066, n1067,
         n1068, n1069, n1070, n1071, n1072, n1073, n1074, n1075, n1076, n1077,
         n1078, n1079, n1080, n1081, n1082, n1083, n1084, n1085, n1086, n1087,
         n1088, n1089, n1090, n1091, n1092, n1093, n1094, n1095, n1096, n1097,
         n1098, n1099, n1100, n1101, n1102, n1103, n1104, n1105, n1106, n1107,
         n1108, n1109, n1110, n1111, n1112, n1113, n1114, n1115, n1116, n1117,
         n1118, n1119, n1120, n1121, n1122, n1123, n1124, n1125, n1126, n1127,
         n1128, n1129, n1130, n1131, n1132, n1133, n1134, n1135, n1136, n1137,
         n1138, n1139, n1140, n1141, n1142, n1143, n1144, n1145, n1146, n1147,
         n1148, n1149, n1150, n1151, n1152, n1153, n1154, n1155, n1156, n1157,
         n1158, n1159, n1160, n1161, n1162, n1163, n1164, n1165, n1166, n1167,
         n1168, n1169, n1170, n1171, n1172, n1173, n1174, n1175, n1176, n1177,
         n1178, n1179, n1180, n1181, n1182, n1183, n1184, n1185, n1186, n1187,
         n1188, n1189, n1190, n1191, n1192, n1193, n1194, n1195, n1196, n1197,
         n1198, n1199, n1200, n1201, n1493, n1494, n1495, n1496, n1497, n1498,
         n1499, n1500, n1501, n1502, n1503, n1504, n1505, n1506, n1507, n1508,
         n1509, n1510, n1511, n1512, n1513, n1514, n1515, n1516, n1517, n1518,
         n1519, n1520, n1521, n1522, n1523, n1524, n1525, n1526, n1527, n1528,
         n1529, n1530, n1531, n1532, n1533, n1534, n1535, n1536, n1537, n1538,
         n1539, n1540, n1541, n1542, n1543, n1544, n1545, n1546, n1547, n1548,
         n1549, n1550, n1551, n1552;
  wire   [31:0] \dma_axi64_dual_core/prdata_reg ;
  wire   [31:1] \dma_axi64_dual_core/periph_tx_req_reg ;
  wire   [31:1] \dma_axi64_dual_core/periph_rx_req_reg ;
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
  tri   \dma_axi64_dual_core/n67 ;
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
  nor_x2_sg U380 ( .A(n424), .B(n425), .X(n423) );
  nand_x8_sg U584 ( .A(n599), .B(n1170), .X(n483) );
  inv_x2_sg U596 ( .A(pwdata[8]), .X(n611) );
  inv_x2_sg U601 ( .A(pwdata[11]), .X(n616) );
  inv_x2_sg U606 ( .A(pwdata[10]), .X(n620) );
  inv_x2_sg U611 ( .A(pwdata[20]), .X(n624) );
  inv_x2_sg U616 ( .A(pwdata[26]), .X(n628) );
  inv_x2_sg U621 ( .A(pwdata[25]), .X(n632) );
  inv_x2_sg U626 ( .A(pwdata[1]), .X(n636) );
  inv_x2_sg U631 ( .A(pwdata[28]), .X(n640) );
  inv_x2_sg U636 ( .A(pwdata[27]), .X(n644) );
  inv_x2_sg U641 ( .A(pwdata[19]), .X(n648) );
  inv_x2_sg U646 ( .A(pwdata[22]), .X(n652) );
  inv_x2_sg U651 ( .A(pwdata[21]), .X(n656) );
  inv_x2_sg U656 ( .A(pwdata[18]), .X(n660) );
  inv_x2_sg U661 ( .A(pwdata[24]), .X(n664) );
  inv_x2_sg U666 ( .A(pwdata[23]), .X(n668) );
  inv_x2_sg U671 ( .A(pwdata[7]), .X(n672) );
  inv_x2_sg U676 ( .A(pwdata[4]), .X(n676) );
  inv_x2_sg U681 ( .A(pwdata[13]), .X(n680) );
  inv_x2_sg U686 ( .A(pwdata[2]), .X(n684) );
  inv_x2_sg U691 ( .A(pwdata[29]), .X(n688) );
  inv_x2_sg U696 ( .A(pwdata[12]), .X(n692) );
  inv_x2_sg U701 ( .A(pwdata[31]), .X(n696) );
  inv_x2_sg U706 ( .A(pwdata[30]), .X(n700) );
  inv_x2_sg U711 ( .A(pwdata[9]), .X(n704) );
  inv_x2_sg U716 ( .A(pwdata[6]), .X(n708) );
  inv_x2_sg U721 ( .A(pwdata[3]), .X(n712) );
  inv_x2_sg U726 ( .A(pwdata[15]), .X(n716) );
  inv_x2_sg U731 ( .A(pwdata[14]), .X(n720) );
  inv_x2_sg U736 ( .A(pwdata[5]), .X(n724) );
  inv_x2_sg U741 ( .A(pwdata[17]), .X(n728) );
  inv_x2_sg U746 ( .A(pwdata[16]), .X(n732) );
  nand_x8_sg U850 ( .A(n770), .B(pwrite), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1411 ) );
  nor_x2_sg U851 ( .A(penable), .B(n1546), .X(n770) );
  nor_x2_sg U1151 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [0]), 
        .B(n418), .X(n1045) );
  nor_x2_sg U1162 ( .A(n1057), .B(n1058), .X(n1054) );
  nand_x8_sg U1183 ( .A(n1074), .B(n771), .X(n432) );
  nor_x2_sg U1184 ( .A(pwrite), .B(penable), .X(n1074) );
  nor_x2_sg U1192 ( .A(n1077), .B(n1031), .X(n1076) );
  nand_x8_sg U1193 ( .A(n1078), .B(n1028), .X(n1031) );
  nor_x2_sg U1195 ( .A(paddr[2]), .B(n1027), .X(n1078) );
  nand_x8_sg U1200 ( .A(paddr[6]), .B(n771), .X(n1027) );
  nand_x8_sg U1203 ( .A(paddr[4]), .B(n771), .X(n418) );
  nand_x8_sg U1209 ( .A(psel), .B(pclken), .X(
        \dma_axi64_dual_core/dma_axi64_apb_mux/n3 ) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_apb_mux/pready_reg  ( 
        .next_state(n1084), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(pready) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/pslverr_reg  ( .next_state(
        n1085), .clocked_on(clk), .force_00(1'b0), .force_01(reset), 
        .force_10(1'b0), .force_11(1'b0), .Q(\dma_axi64_dual_core/pslverr_reg ) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[0]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1316 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .Q(\dma_axi64_dual_core/prdata_reg [0]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[1]  ( .next_state(
        n1087), .clocked_on(clk), .force_00(1'b0), .force_01(reset), 
        .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/prdata_reg [1]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[2]  ( .next_state(
        n1088), .clocked_on(clk), .force_00(1'b0), .force_01(reset), 
        .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/prdata_reg [2]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[3]  ( .next_state(
        n1086), .clocked_on(clk), .force_00(1'b0), .force_01(reset), 
        .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/prdata_reg [3]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[4]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1320 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1151) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[5]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1321 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1152) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[6]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1322 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1153) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[7]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1323 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1154) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[8]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1324 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1155) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[9]  ( .next_state(
        \dma_axi64_dual_core/dma_axi64_reg/n1325 ), .clocked_on(clk), 
        .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), 
        .QN(n1156) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[10]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1326 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .QN(n1157) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[11]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1327 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .QN(n1158) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[12]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1328 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .QN(n1159) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[13]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1329 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .QN(n1160) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[14]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1330 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .QN(n1161) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[15]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1331 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .QN(n1162) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[16]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1332 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [16]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[17]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1333 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [17]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[18]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1334 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [18]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[19]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1335 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [19]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[20]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1336 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [20]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[21]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1337 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [21]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[22]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1338 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [22]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[23]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1339 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [23]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[24]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1340 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [24]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[25]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1341 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [25]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[26]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1342 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [26]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[27]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1343 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [27]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[28]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1344 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [28]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[29]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1345 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [29]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[30]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1346 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [30]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/prdata_reg[31]  ( 
        .next_state(\dma_axi64_dual_core/dma_axi64_reg/n1347 ), .clocked_on(
        clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(
        1'b0), .Q(\dma_axi64_dual_core/prdata_reg [31]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/int_all_proc_reg[0]  ( 
        .next_state(n1552), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(INT[0]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[1]  ( 
        .next_state(n1108), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [1]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[2]  ( 
        .next_state(n1104), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [2]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[3]  ( 
        .next_state(n1093), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [3]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[4]  ( 
        .next_state(n1094), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [4]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[5]  ( 
        .next_state(n1090), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [5]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[6]  ( 
        .next_state(n1091), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [6]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[7]  ( 
        .next_state(n1111), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [7]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[8]  ( 
        .next_state(n1106), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [8]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[9]  ( 
        .next_state(n1092), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [9]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[10]  ( 
        .next_state(n1095), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [10]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[11]  ( 
        .next_state(n1097), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [11]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[12]  ( 
        .next_state(n1098), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [12]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[13]  ( 
        .next_state(n1117), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [13]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[14]  ( 
        .next_state(n1118), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [14]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[15]  ( 
        .next_state(n1119), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [15]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[16]  ( 
        .next_state(n1096), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [16]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[17]  ( 
        .next_state(n1109), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [17]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[18]  ( 
        .next_state(n1110), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [18]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[19]  ( 
        .next_state(n1107), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [19]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[20]  ( 
        .next_state(n1115), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [20]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[21]  ( 
        .next_state(n1116), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [21]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[22]  ( 
        .next_state(n1112), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [22]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[23]  ( 
        .next_state(n1113), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [23]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[24]  ( 
        .next_state(n1089), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [24]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[25]  ( 
        .next_state(n1105), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [25]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[26]  ( 
        .next_state(n1102), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [26]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[27]  ( 
        .next_state(n1103), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [27]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[28]  ( 
        .next_state(n1100), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [28]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[29]  ( 
        .next_state(n1101), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [29]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[30]  ( 
        .next_state(n1099), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [30]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_tx_req_reg_reg[31]  ( 
        .next_state(n1114), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_tx_req_reg [31]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[1]  ( 
        .next_state(n1126), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [1]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[2]  ( 
        .next_state(n1138), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [2]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[3]  ( 
        .next_state(n1145), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [3]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[4]  ( 
        .next_state(n1136), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [4]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[5]  ( 
        .next_state(n1148), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [5]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[6]  ( 
        .next_state(n1144), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [6]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[7]  ( 
        .next_state(n1135), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [7]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[8]  ( 
        .next_state(n1120), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [8]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[9]  ( 
        .next_state(n1143), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [9]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[10]  ( 
        .next_state(n1122), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [10]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[11]  ( 
        .next_state(n1121), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [11]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[12]  ( 
        .next_state(n1140), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [12]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[13]  ( 
        .next_state(n1137), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [13]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[14]  ( 
        .next_state(n1147), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [14]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[15]  ( 
        .next_state(n1146), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [15]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[16]  ( 
        .next_state(n1150), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [16]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[17]  ( 
        .next_state(n1149), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [17]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[18]  ( 
        .next_state(n1132), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [18]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[19]  ( 
        .next_state(n1129), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [19]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[20]  ( 
        .next_state(n1123), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [20]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[21]  ( 
        .next_state(n1131), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [21]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[22]  ( 
        .next_state(n1130), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [22]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[23]  ( 
        .next_state(n1134), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [23]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[24]  ( 
        .next_state(n1133), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [24]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[25]  ( 
        .next_state(n1125), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [25]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[26]  ( 
        .next_state(n1124), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [26]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[27]  ( 
        .next_state(n1128), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [27]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[28]  ( 
        .next_state(n1127), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [28]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[29]  ( 
        .next_state(n1139), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [29]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[30]  ( 
        .next_state(n1142), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [30]) );
  \**FFGEN**  \dma_axi64_dual_core/dma_axi64_reg/periph_rx_req_reg_reg[31]  ( 
        .next_state(n1141), .clocked_on(clk), .force_00(1'b0), .force_01(reset), .force_10(1'b0), .force_11(1'b0), .Q(
        \dma_axi64_dual_core/periph_rx_req_reg [31]) );
  nor_x1_sg \dma_axi64_dual_core/dma_axi64_reg/C1185  ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/n1411 ), .B(
        \dma_axi64_dual_core/dma_axi64_reg/N380 ), .X(
        \dma_axi64_dual_core/dma_axi64_reg/wr_joint0 ) );
  nor_x1_sg \dma_axi64_dual_core/dma_axi64_reg/C1187  ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/n1411 ), .B(n1164), .X(
        \dma_axi64_dual_core/dma_axi64_reg/wr_start0 ) );
  nor_x1_sg \dma_axi64_dual_core/dma_axi64_apb_mux/U9  ( .A(
        \dma_axi64_dual_core/dma_axi64_apb_mux/n3 ), .B(
        \dma_axi64_dual_core/dma_axi64_apb_mux/n8 ), .X(
        \dma_axi64_dual_core/psel0 ) );
  nor_x1_sg \dma_axi64_dual_core/dma_axi64_apb_mux/U6  ( .A(n1550), .B(n1083), 
        .X(\dma_axi64_dual_core/psel1 ) );
  nor_x1_sg \dma_axi64_dual_core/dma_axi64_reg/C1188  ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/n1411 ), .B(n1168), .X(
        \dma_axi64_dual_core/dma_axi64_reg/wr_prio0 ) );
  nor_x1_sg \dma_axi64_dual_core/dma_axi64_reg/C1186  ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/n1411 ), .B(n1166), .X(
        \dma_axi64_dual_core/dma_axi64_reg/wr_clkdiv0 ) );
  inv_x1_sg \dma_axi64_dual_core/U33  ( .A(\dma_axi64_dual_core/n32 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [31]) );
  inv_x1_sg \dma_axi64_dual_core/U34  ( .A(\dma_axi64_dual_core/n33 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [30]) );
  inv_x1_sg \dma_axi64_dual_core/U35  ( .A(\dma_axi64_dual_core/n34 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [29]) );
  inv_x1_sg \dma_axi64_dual_core/U36  ( .A(\dma_axi64_dual_core/n35 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [28]) );
  inv_x1_sg \dma_axi64_dual_core/U37  ( .A(\dma_axi64_dual_core/n36 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [27]) );
  inv_x1_sg \dma_axi64_dual_core/U38  ( .A(\dma_axi64_dual_core/n37 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [26]) );
  inv_x1_sg \dma_axi64_dual_core/U39  ( .A(\dma_axi64_dual_core/n38 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [25]) );
  inv_x1_sg \dma_axi64_dual_core/U40  ( .A(\dma_axi64_dual_core/n39 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [24]) );
  inv_x1_sg \dma_axi64_dual_core/U41  ( .A(\dma_axi64_dual_core/n40 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [23]) );
  inv_x1_sg \dma_axi64_dual_core/U42  ( .A(\dma_axi64_dual_core/n41 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [22]) );
  inv_x1_sg \dma_axi64_dual_core/U43  ( .A(\dma_axi64_dual_core/n42 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [21]) );
  inv_x1_sg \dma_axi64_dual_core/U44  ( .A(\dma_axi64_dual_core/n43 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [20]) );
  inv_x1_sg \dma_axi64_dual_core/U45  ( .A(\dma_axi64_dual_core/n44 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [19]) );
  inv_x1_sg \dma_axi64_dual_core/U46  ( .A(\dma_axi64_dual_core/n45 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [18]) );
  inv_x1_sg \dma_axi64_dual_core/U47  ( .A(\dma_axi64_dual_core/n46 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [17]) );
  inv_x1_sg \dma_axi64_dual_core/U48  ( .A(\dma_axi64_dual_core/n47 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [16]) );
  inv_x1_sg \dma_axi64_dual_core/U49  ( .A(\dma_axi64_dual_core/n48 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [15]) );
  inv_x1_sg \dma_axi64_dual_core/U50  ( .A(\dma_axi64_dual_core/n49 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [14]) );
  inv_x1_sg \dma_axi64_dual_core/U51  ( .A(\dma_axi64_dual_core/n50 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [13]) );
  inv_x1_sg \dma_axi64_dual_core/U52  ( .A(\dma_axi64_dual_core/n51 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [12]) );
  inv_x1_sg \dma_axi64_dual_core/U53  ( .A(\dma_axi64_dual_core/n52 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [11]) );
  inv_x1_sg \dma_axi64_dual_core/U54  ( .A(\dma_axi64_dual_core/n53 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [10]) );
  inv_x1_sg \dma_axi64_dual_core/U55  ( .A(\dma_axi64_dual_core/n54 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [9]) );
  inv_x1_sg \dma_axi64_dual_core/U56  ( .A(\dma_axi64_dual_core/n55 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [8]) );
  inv_x1_sg \dma_axi64_dual_core/U57  ( .A(\dma_axi64_dual_core/n56 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [7]) );
  inv_x1_sg \dma_axi64_dual_core/U58  ( .A(\dma_axi64_dual_core/n57 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [6]) );
  inv_x1_sg \dma_axi64_dual_core/U59  ( .A(\dma_axi64_dual_core/n58 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [5]) );
  inv_x1_sg \dma_axi64_dual_core/U60  ( .A(\dma_axi64_dual_core/n59 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [4]) );
  inv_x1_sg \dma_axi64_dual_core/U61  ( .A(\dma_axi64_dual_core/n60 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [3]) );
  inv_x1_sg \dma_axi64_dual_core/U62  ( .A(\dma_axi64_dual_core/n61 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [2]) );
  inv_x1_sg \dma_axi64_dual_core/U63  ( .A(\dma_axi64_dual_core/n62 ), .X(
        \dma_axi64_dual_core/periph_tx_req0 [1]) );
  inv_x1_sg \dma_axi64_dual_core/U2  ( .A(\dma_axi64_dual_core/n1 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [31]) );
  inv_x1_sg \dma_axi64_dual_core/U3  ( .A(\dma_axi64_dual_core/n2 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [30]) );
  inv_x1_sg \dma_axi64_dual_core/U4  ( .A(\dma_axi64_dual_core/n3 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [29]) );
  inv_x1_sg \dma_axi64_dual_core/U5  ( .A(\dma_axi64_dual_core/n4 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [28]) );
  inv_x1_sg \dma_axi64_dual_core/U6  ( .A(\dma_axi64_dual_core/n5 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [27]) );
  inv_x1_sg \dma_axi64_dual_core/U7  ( .A(\dma_axi64_dual_core/n6 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [26]) );
  inv_x1_sg \dma_axi64_dual_core/U8  ( .A(\dma_axi64_dual_core/n7 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [25]) );
  inv_x1_sg \dma_axi64_dual_core/U9  ( .A(\dma_axi64_dual_core/n8 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [24]) );
  inv_x1_sg \dma_axi64_dual_core/U10  ( .A(\dma_axi64_dual_core/n9 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [23]) );
  inv_x1_sg \dma_axi64_dual_core/U11  ( .A(\dma_axi64_dual_core/n10 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [22]) );
  inv_x1_sg \dma_axi64_dual_core/U12  ( .A(\dma_axi64_dual_core/n11 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [21]) );
  inv_x1_sg \dma_axi64_dual_core/U13  ( .A(\dma_axi64_dual_core/n12 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [20]) );
  inv_x1_sg \dma_axi64_dual_core/U14  ( .A(\dma_axi64_dual_core/n13 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [19]) );
  inv_x1_sg \dma_axi64_dual_core/U15  ( .A(\dma_axi64_dual_core/n14 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [18]) );
  inv_x1_sg \dma_axi64_dual_core/U16  ( .A(\dma_axi64_dual_core/n15 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [17]) );
  inv_x1_sg \dma_axi64_dual_core/U17  ( .A(\dma_axi64_dual_core/n16 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [16]) );
  inv_x1_sg \dma_axi64_dual_core/U18  ( .A(\dma_axi64_dual_core/n17 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [15]) );
  inv_x1_sg \dma_axi64_dual_core/U19  ( .A(\dma_axi64_dual_core/n18 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [14]) );
  inv_x1_sg \dma_axi64_dual_core/U20  ( .A(\dma_axi64_dual_core/n19 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [13]) );
  inv_x1_sg \dma_axi64_dual_core/U21  ( .A(\dma_axi64_dual_core/n20 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [12]) );
  inv_x1_sg \dma_axi64_dual_core/U22  ( .A(\dma_axi64_dual_core/n21 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [11]) );
  inv_x1_sg \dma_axi64_dual_core/U23  ( .A(\dma_axi64_dual_core/n22 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [10]) );
  inv_x1_sg \dma_axi64_dual_core/U24  ( .A(\dma_axi64_dual_core/n23 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [9]) );
  inv_x1_sg \dma_axi64_dual_core/U25  ( .A(\dma_axi64_dual_core/n24 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [8]) );
  inv_x1_sg \dma_axi64_dual_core/U26  ( .A(\dma_axi64_dual_core/n25 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [7]) );
  inv_x1_sg \dma_axi64_dual_core/U27  ( .A(\dma_axi64_dual_core/n26 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [6]) );
  inv_x1_sg \dma_axi64_dual_core/U28  ( .A(\dma_axi64_dual_core/n27 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [5]) );
  inv_x1_sg \dma_axi64_dual_core/U29  ( .A(\dma_axi64_dual_core/n28 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [4]) );
  inv_x1_sg \dma_axi64_dual_core/U30  ( .A(\dma_axi64_dual_core/n29 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [3]) );
  inv_x1_sg \dma_axi64_dual_core/U31  ( .A(\dma_axi64_dual_core/n30 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [2]) );
  inv_x1_sg \dma_axi64_dual_core/U32  ( .A(\dma_axi64_dual_core/n31 ), .X(
        \dma_axi64_dual_core/periph_rx_req0 [1]) );
  inv_x1_sg U1283 ( .A(n1035), .X(n1542) );
  inv_x2_sg U1284 ( .A(n439), .X(n1201) );
  nor_x1_sg U1285 ( .A(n1035), .B(n1494), .X(n439) );
  inv_x2_sg U1286 ( .A(n451), .X(n1193) );
  inv_x2_sg U1287 ( .A(n448), .X(n1197) );
  nor_x1_sg U1288 ( .A(n1070), .B(n1035), .X(n448) );
  inv_x2_sg U1289 ( .A(n1540), .X(n1178) );
  inv_x1_sg U1290 ( .A(n1022), .X(n1540) );
  inv_x2_sg U1291 ( .A(n612), .X(n1182) );
  nor_x1_sg U1292 ( .A(n733), .B(n734), .X(n612) );
  inv_x2_sg U1293 ( .A(n484), .X(n1188) );
  nor_x1_sg U1294 ( .A(n575), .B(n576), .X(n484) );
  nand_x2_sg U1295 ( .A(n1075), .B(n1493), .X(
        \dma_axi64_dual_core/dma_axi64_reg/N405 ) );
  nand_x2_sg U1296 ( .A(n1076), .B(n1032), .X(
        \dma_axi64_dual_core/dma_axi64_reg/N388 ) );
  inv_x2_sg U1297 ( .A(n483), .X(n1189) );
  inv_x4_sg U1298 ( .A(n1192), .X(n1191) );
  inv_x4_sg U1299 ( .A(n1196), .X(n1195) );
  inv_x4_sg U1300 ( .A(n1181), .X(n1180) );
  inv_x4_sg U1301 ( .A(n1187), .X(n1186) );
  inv_x4_sg U1302 ( .A(n1200), .X(n1199) );
  inv_x4_sg U1303 ( .A(n1177), .X(n1176) );
  inv_x4_sg U1304 ( .A(n403), .X(n1171) );
  inv_x4_sg U1305 ( .A(n443), .X(n1173) );
  inv_x4_sg U1306 ( .A(n1178), .X(n1177) );
  inv_x4_sg U1307 ( .A(n1201), .X(n1200) );
  inv_x4_sg U1308 ( .A(n1197), .X(n1196) );
  inv_x4_sg U1309 ( .A(n1182), .X(n1181) );
  inv_x4_sg U1310 ( .A(n1188), .X(n1187) );
  inv_x4_sg U1311 ( .A(n1193), .X(n1192) );
  inv_x1_sg U1312 ( .A(\dma_axi64_dual_core/dma_axi64_reg/N397 ), .X(n1163) );
  inv_x2_sg U1313 ( .A(n1163), .X(n1164) );
  inv_x4_sg U1314 ( .A(\dma_axi64_dual_core/dma_axi64_reg/N388 ), .X(n1165) );
  inv_x8_sg U1315 ( .A(n1165), .X(n1166) );
  inv_x4_sg U1316 ( .A(\dma_axi64_dual_core/dma_axi64_reg/N405 ), .X(n1167) );
  inv_x8_sg U1317 ( .A(n1167), .X(n1168) );
  nor_x4_sg U1318 ( .A(n432), .B(n1166), .X(n442) );
  nor_x4_sg U1319 ( .A(paddr[1]), .B(paddr[0]), .X(n1079) );
  nor_x1_sg U1320 ( .A(periph_rx_clr[24]), .B(periph_rx_clr[25]), .X(n742) );
  nor_x1_sg U1321 ( .A(periph_rx_clr[28]), .B(periph_rx_clr[29]), .X(n740) );
  nor_x1_sg U1322 ( .A(periph_rx_clr[31]), .B(periph_rx_clr[3]), .X(n748) );
  nor_x1_sg U1323 ( .A(periph_rx_clr[6]), .B(periph_rx_clr[7]), .X(n746) );
  nor_x1_sg U1324 ( .A(periph_rx_clr[17]), .B(periph_rx_clr[18]), .X(n762) );
  nor_x1_sg U1325 ( .A(periph_rx_clr[19]), .B(periph_rx_clr[1]), .X(n761) );
  nor_x1_sg U1326 ( .A(periph_tx_clr[24]), .B(periph_tx_clr[25]), .X(n584) );
  nor_x1_sg U1327 ( .A(periph_tx_clr[28]), .B(periph_tx_clr[29]), .X(n582) );
  nor_x1_sg U1328 ( .A(periph_tx_clr[31]), .B(periph_tx_clr[3]), .X(n590) );
  nor_x1_sg U1329 ( .A(periph_tx_clr[6]), .B(periph_tx_clr[7]), .X(n588) );
  nor_x1_sg U1330 ( .A(periph_tx_clr[17]), .B(periph_tx_clr[18]), .X(n606) );
  nor_x1_sg U1331 ( .A(periph_tx_clr[19]), .B(periph_tx_clr[1]), .X(n605) );
  nor_x1_sg U1332 ( .A(n737), .B(n738), .X(n736) );
  nor_x1_sg U1333 ( .A(periph_rx_clr[2]), .B(periph_rx_clr[30]), .X(n739) );
  nor_x1_sg U1334 ( .A(n743), .B(n744), .X(n735) );
  nor_x1_sg U1335 ( .A(periph_rx_clr[8]), .B(periph_rx_clr[9]), .X(n745) );
  inv_x2_sg U1336 ( .A(n600), .X(n1169) );
  nor_x1_sg U1337 ( .A(n1024), .B(n1025), .X(n600) );
  nor_x1_sg U1338 ( .A(n579), .B(n580), .X(n578) );
  nor_x1_sg U1339 ( .A(periph_tx_clr[2]), .B(periph_tx_clr[30]), .X(n581) );
  nor_x1_sg U1340 ( .A(n585), .B(n586), .X(n577) );
  nor_x1_sg U1341 ( .A(periph_tx_clr[8]), .B(periph_tx_clr[9]), .X(n587) );
  nand_x1_sg U1342 ( .A(n1056), .B(\dma_axi64_dual_core/core0_clkdiv [0]), .X(
        n1055) );
  nand_x1_sg U1343 ( .A(n1052), .B(n1053), .X(n1051) );
  nand_x1_sg U1344 ( .A(pwrite), .B(n418), .X(n417) );
  nand_x4_sg U1345 ( .A(n1071), .B(n1072), .X(n1035) );
  nor_x1_sg U1346 ( .A(n1027), .B(n1073), .X(n1072) );
  nand_x1_sg U1347 ( .A(n1047), .B(n1048), .X(n1046) );
  nand_x1_sg U1348 ( .A(n1049), .B(\dma_axi64_dual_core/rd_prio_top_num0 [0]), 
        .X(n1048) );
  nand_x1_sg U1349 ( .A(n428), .B(n418), .X(n427) );
  nand_x1_sg U1350 ( .A(n429), .B(\dma_axi64_dual_core/dma_axi64_reg/n1411 ), 
        .X(n428) );
  nand_x1_sg U1351 ( .A(n415), .B(n416), .X(n414) );
  nand_x1_sg U1352 ( .A(paddr[3]), .B(n417), .X(n416) );
  nand_x1_sg U1353 ( .A(paddr[7]), .B(n420), .X(n412) );
  nand_x1_sg U1354 ( .A(\dma_axi64_dual_core/dma_axi64_reg/n1411 ), .B(n421), 
        .X(n420) );
  nor_x1_sg U1355 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[4] ), 
        .B(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[5] ), .X(n767)
         );
  nor_x1_sg U1356 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[6] ), 
        .B(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[7] ), .X(n766)
         );
  nor_x1_sg U1357 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[0] ), 
        .B(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[1] ), .X(n769)
         );
  nor_x1_sg U1358 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[2] ), 
        .B(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[3] ), .X(n768)
         );
  nand_x1_sg U1359 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [31]), .X(
        n779) );
  nand_x1_sg U1360 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [31]), .B(n1194), 
        .X(n778) );
  nand_x1_sg U1361 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [31]), .B(n1200), 
        .X(n775) );
  nand_x1_sg U1362 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [31]), .B(n1175), .X(n774) );
  nand_x1_sg U1363 ( .A(n1192), .B(\dma_axi64_dual_core/periph_rx_req_reg [31]), .X(n776) );
  nand_x1_sg U1364 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [30]), .X(
        n787) );
  nand_x1_sg U1365 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [30]), .B(n1194), 
        .X(n786) );
  nand_x1_sg U1366 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [30]), .B(n1198), 
        .X(n783) );
  nand_x1_sg U1367 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [30]), .B(n1175), .X(n782) );
  nand_x1_sg U1368 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [30]), .X(n784) );
  nand_x1_sg U1369 ( .A(n403), .B(\dma_axi64_dual_core/prdata_reg [29]), .X(
        n795) );
  nand_x1_sg U1370 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [29]), .B(n1194), 
        .X(n794) );
  nand_x1_sg U1371 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [29]), .B(n1198), 
        .X(n791) );
  nand_x1_sg U1372 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [29]), .B(n1175), .X(n790) );
  nand_x1_sg U1373 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [29]), .X(n792) );
  nand_x1_sg U1374 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [28]), .X(
        n803) );
  nand_x1_sg U1375 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [28]), .B(n1194), 
        .X(n802) );
  nand_x1_sg U1376 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [28]), .B(n1198), 
        .X(n799) );
  nand_x1_sg U1377 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [28]), .B(n1175), .X(n798) );
  nand_x1_sg U1378 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [28]), .X(n800) );
  nand_x1_sg U1379 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [27]), .X(
        n811) );
  nand_x1_sg U1380 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [27]), .B(n1194), 
        .X(n810) );
  nand_x1_sg U1381 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [27]), .B(n1198), 
        .X(n807) );
  nand_x1_sg U1382 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [27]), .B(n1175), .X(n806) );
  nand_x1_sg U1383 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [27]), .X(n808) );
  nand_x1_sg U1384 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [26]), .X(
        n819) );
  nand_x1_sg U1385 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [26]), .B(n1194), 
        .X(n818) );
  nand_x1_sg U1386 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [26]), .B(n1198), 
        .X(n815) );
  nand_x1_sg U1387 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [26]), .B(n1175), .X(n814) );
  nand_x1_sg U1388 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [26]), .X(n816) );
  nand_x1_sg U1389 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [25]), .X(
        n827) );
  nand_x1_sg U1390 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [25]), .B(n1194), 
        .X(n826) );
  nand_x1_sg U1391 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [25]), .B(n1198), 
        .X(n823) );
  nand_x1_sg U1392 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [25]), .B(n1175), .X(n822) );
  nand_x1_sg U1393 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [25]), .X(n824) );
  nand_x1_sg U1394 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [24]), .X(
        n835) );
  nand_x1_sg U1395 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [24]), .B(n1194), 
        .X(n834) );
  nand_x1_sg U1396 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [24]), .B(n1198), 
        .X(n831) );
  nand_x1_sg U1397 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [24]), .B(n1175), .X(n830) );
  nand_x1_sg U1398 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [24]), .X(n832) );
  nand_x1_sg U1399 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [23]), .X(
        n843) );
  nand_x1_sg U1400 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [23]), .B(n1194), 
        .X(n842) );
  nand_x1_sg U1401 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [23]), .B(n1198), 
        .X(n839) );
  nand_x1_sg U1402 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [23]), .B(n1175), .X(n838) );
  nand_x1_sg U1403 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [23]), .X(n840) );
  nand_x1_sg U1404 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [22]), .X(
        n851) );
  nand_x1_sg U1405 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [22]), .B(n1194), 
        .X(n850) );
  nand_x1_sg U1406 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [22]), .B(n1198), 
        .X(n847) );
  nand_x1_sg U1407 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [22]), .B(n1175), .X(n846) );
  nand_x1_sg U1408 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [22]), .X(n848) );
  nand_x1_sg U1409 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [21]), .X(
        n859) );
  nand_x1_sg U1410 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [21]), .B(n1194), 
        .X(n858) );
  nand_x1_sg U1411 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [21]), .B(n1198), 
        .X(n855) );
  nand_x1_sg U1412 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [21]), .B(n1175), .X(n854) );
  nand_x1_sg U1413 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [21]), .X(n856) );
  nand_x1_sg U1414 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [20]), .X(
        n867) );
  nand_x1_sg U1415 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [20]), .B(n1194), 
        .X(n866) );
  nand_x1_sg U1416 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [20]), .B(n1198), 
        .X(n863) );
  nand_x1_sg U1417 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [20]), .B(n1175), .X(n862) );
  nand_x1_sg U1418 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [20]), .X(n864) );
  nand_x1_sg U1419 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [19]), .X(
        n875) );
  nand_x1_sg U1420 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [19]), .B(n1194), 
        .X(n874) );
  nand_x1_sg U1421 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [19]), .B(n1198), 
        .X(n871) );
  nand_x1_sg U1422 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [19]), .B(n1175), .X(n870) );
  nand_x1_sg U1423 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [19]), .X(n872) );
  nand_x1_sg U1424 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [18]), .X(
        n883) );
  nand_x1_sg U1425 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [18]), .B(n1194), 
        .X(n882) );
  nand_x1_sg U1426 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [18]), .B(n1198), 
        .X(n879) );
  nand_x1_sg U1427 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [18]), .B(n1175), .X(n878) );
  nand_x1_sg U1428 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [18]), .X(n880) );
  nand_x1_sg U1429 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [17]), .X(
        n891) );
  nand_x1_sg U1430 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [17]), .B(n1194), 
        .X(n890) );
  nand_x1_sg U1431 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [17]), .B(n1198), 
        .X(n887) );
  nand_x1_sg U1432 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [17]), .B(n1175), .X(n886) );
  nand_x1_sg U1433 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [17]), .X(n888) );
  nand_x1_sg U1434 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [16]), .X(
        n899) );
  nand_x1_sg U1435 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [16]), .B(n1194), 
        .X(n898) );
  nand_x1_sg U1436 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [16]), .B(n1198), 
        .X(n895) );
  nand_x1_sg U1437 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [16]), .B(n1175), .X(n894) );
  nand_x1_sg U1438 ( .A(n1190), .B(\dma_axi64_dual_core/periph_rx_req_reg [16]), .X(n896) );
  nand_x1_sg U1439 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [15]), .B(n1198), 
        .X(n903) );
  nand_x1_sg U1440 ( .A(\dma_axi64_dual_core/wr_prio_high0 ), .B(n1174), .X(
        n904) );
  nand_x1_sg U1441 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [15]), .B(n1194), 
        .X(n908) );
  nand_x1_sg U1442 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [15]), .B(n1190), .X(n909) );
  nand_x1_sg U1443 ( .A(n1175), .B(\dma_axi64_dual_core/periph_tx_req_reg [15]), .X(n905) );
  nand_x1_sg U1444 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [14]), .B(n1198), 
        .X(n913) );
  nand_x1_sg U1445 ( .A(\dma_axi64_dual_core/wr_prio_high_num0 [2]), .B(n443), 
        .X(n914) );
  nand_x1_sg U1446 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [14]), .B(n1194), 
        .X(n918) );
  nand_x1_sg U1447 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [14]), .B(n1190), .X(n919) );
  nand_x1_sg U1448 ( .A(n1175), .B(\dma_axi64_dual_core/periph_tx_req_reg [14]), .X(n915) );
  nand_x1_sg U1449 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [13]), .B(n1198), 
        .X(n923) );
  nand_x1_sg U1450 ( .A(\dma_axi64_dual_core/wr_prio_high_num0 [1]), .B(n1174), 
        .X(n924) );
  nand_x1_sg U1451 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [13]), .B(n1194), 
        .X(n928) );
  nand_x1_sg U1452 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [13]), .B(n1190), .X(n929) );
  nand_x1_sg U1453 ( .A(n1175), .B(\dma_axi64_dual_core/periph_tx_req_reg [13]), .X(n925) );
  nand_x1_sg U1454 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [12]), .B(n1198), 
        .X(n933) );
  nand_x1_sg U1455 ( .A(\dma_axi64_dual_core/wr_prio_high_num0 [0]), .B(n1174), 
        .X(n934) );
  nand_x1_sg U1456 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [12]), .B(n1194), 
        .X(n938) );
  nand_x1_sg U1457 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [12]), .B(n1190), .X(n939) );
  nand_x1_sg U1458 ( .A(n1175), .B(\dma_axi64_dual_core/periph_tx_req_reg [12]), .X(n935) );
  nand_x1_sg U1459 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [11]), .B(n1198), 
        .X(n943) );
  nand_x1_sg U1460 ( .A(\dma_axi64_dual_core/wr_prio_top0 ), .B(n1174), .X(
        n944) );
  nand_x1_sg U1461 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [11]), .B(n1194), 
        .X(n948) );
  nand_x1_sg U1462 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [11]), .B(n1190), .X(n949) );
  nand_x1_sg U1463 ( .A(n1175), .B(\dma_axi64_dual_core/periph_tx_req_reg [11]), .X(n945) );
  nand_x1_sg U1464 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [10]), .B(n1198), 
        .X(n953) );
  nand_x1_sg U1465 ( .A(\dma_axi64_dual_core/wr_prio_top_num0 [2]), .B(n1174), 
        .X(n954) );
  nand_x1_sg U1466 ( .A(
        \dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [10]), .B(n1196), 
        .X(n958) );
  nand_x1_sg U1467 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [10]), .B(n1190), .X(n959) );
  nand_x1_sg U1468 ( .A(n1177), .B(\dma_axi64_dual_core/periph_tx_req_reg [10]), .X(n955) );
  nand_x1_sg U1469 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [9]), .B(n1198), .X(n963) );
  nand_x1_sg U1470 ( .A(\dma_axi64_dual_core/wr_prio_top_num0 [1]), .B(n1174), 
        .X(n964) );
  nand_x1_sg U1471 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [9]), .B(n1194), .X(n968) );
  nand_x1_sg U1472 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [9]), .B(n1190), 
        .X(n969) );
  nand_x1_sg U1473 ( .A(n1175), .B(\dma_axi64_dual_core/periph_tx_req_reg [9]), 
        .X(n965) );
  nand_x1_sg U1474 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [8]), .B(n1198), .X(n973) );
  nand_x1_sg U1475 ( .A(\dma_axi64_dual_core/wr_prio_top_num0 [0]), .B(n1174), 
        .X(n974) );
  nand_x1_sg U1476 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [8]), .B(n1194), .X(n978) );
  nand_x1_sg U1477 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [8]), .B(n1190), 
        .X(n979) );
  nand_x1_sg U1478 ( .A(n1175), .B(\dma_axi64_dual_core/periph_tx_req_reg [8]), 
        .X(n975) );
  nand_x1_sg U1479 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [7]), .B(n1194), .X(n990) );
  nand_x1_sg U1480 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [7]), .B(n1175), 
        .X(n985) );
  nand_x1_sg U1481 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [7]), .B(n1190), 
        .X(n984) );
  nand_x1_sg U1482 ( .A(\dma_axi64_dual_core/rd_prio_high0 ), .B(n1174), .X(
        n987) );
  nand_x1_sg U1483 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [7]), .B(n1198), .X(n986) );
  nand_x1_sg U1484 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [6]), .B(n1194), .X(n1002) );
  nand_x1_sg U1485 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [6]), .B(n1175), 
        .X(n997) );
  nand_x1_sg U1486 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [6]), .B(n1190), 
        .X(n996) );
  nand_x1_sg U1487 ( .A(\dma_axi64_dual_core/rd_prio_high_num0 [2]), .B(n1174), 
        .X(n999) );
  nand_x1_sg U1488 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [6]), .B(n1198), .X(n998) );
  nand_x1_sg U1489 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [5]), .B(n1194), .X(n1014) );
  nand_x1_sg U1490 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [5]), .B(n1175), 
        .X(n1009) );
  nand_x1_sg U1491 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [5]), .B(n1190), 
        .X(n1008) );
  nand_x1_sg U1492 ( .A(\dma_axi64_dual_core/rd_prio_high_num0 [1]), .B(n1174), 
        .X(n1011) );
  nand_x1_sg U1493 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [5]), .B(n1198), .X(n1010) );
  nand_x1_sg U1494 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [4]), .B(n1194), .X(n1038) );
  nand_x1_sg U1495 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [4]), .B(n1175), 
        .X(n1021) );
  nand_x1_sg U1496 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [4]), .B(n1190), 
        .X(n1020) );
  nand_x1_sg U1497 ( .A(\dma_axi64_dual_core/rd_prio_high_num0 [0]), .B(n1174), 
        .X(n1034) );
  nand_x1_sg U1498 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [4]), .B(n1198), .X(n1033) );
  nand_x1_sg U1499 ( .A(\dma_axi64_dual_core/core0_clkdiv [3]), .B(n442), .X(
        n441) );
  nand_x1_sg U1500 ( .A(\dma_axi64_dual_core/rd_prio_top0 ), .B(n1174), .X(
        n440) );
  nand_x1_sg U1501 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [3]), .B(n1190), 
        .X(n450) );
  nand_x1_sg U1502 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [3]), .B(n1194), .X(n447) );
  nand_x1_sg U1503 ( .A(\dma_axi64_dual_core/prdata_reg [3]), .B(n1172), .X(
        n446) );
  nand_x1_sg U1504 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [3]), .B(n1198), .X(n438) );
  nand_x1_sg U1505 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [3]), .B(n1175), 
        .X(n437) );
  nand_x1_sg U1506 ( .A(\dma_axi64_dual_core/core0_clkdiv [2]), .B(n442), .X(
        n473) );
  nand_x1_sg U1507 ( .A(\dma_axi64_dual_core/rd_prio_top_num0 [2]), .B(n1174), 
        .X(n472) );
  nand_x1_sg U1508 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [2]), .B(n1190), 
        .X(n479) );
  nand_x1_sg U1509 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [2]), .B(n1194), .X(n477) );
  nand_x1_sg U1510 ( .A(\dma_axi64_dual_core/prdata_reg [2]), .B(n1172), .X(
        n476) );
  nand_x1_sg U1511 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [2]), .B(n1198), .X(n471) );
  nand_x1_sg U1512 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [2]), .B(n1175), 
        .X(n470) );
  nand_x1_sg U1513 ( .A(\dma_axi64_dual_core/core0_clkdiv [1]), .B(n442), .X(
        n459) );
  nand_x1_sg U1514 ( .A(\dma_axi64_dual_core/rd_prio_top_num0 [1]), .B(n1174), 
        .X(n458) );
  nand_x1_sg U1515 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [1]), .B(n1190), 
        .X(n465) );
  nand_x1_sg U1516 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [1]), .B(n1194), .X(n463) );
  nand_x1_sg U1517 ( .A(\dma_axi64_dual_core/prdata_reg [1]), .B(n1172), .X(
        n462) );
  nand_x1_sg U1518 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat0 [1]), .B(n1198), .X(n457) );
  nand_x1_sg U1519 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [1]), .B(n1175), 
        .X(n456) );
  nand_x1_sg U1520 ( .A(n1068), .B(n1069), .X(n1067) );
  nand_x1_sg U1521 ( .A(\dma_axi64_dual_core/dma_axi64_reg/user_def0_stat1 [0]), .B(n1194), .X(n1068) );
  nand_x1_sg U1522 ( .A(n1172), .B(\dma_axi64_dual_core/prdata_reg [0]), .X(
        n1069) );
  nand_x1_sg U1523 ( .A(n1044), .B(n1542), .X(n1043) );
  nand_x1_sg U1524 ( .A(n1023), .B(n1046), .X(n1042) );
  nor_x1_sg U1525 ( .A(n410), .B(n411), .X(n409) );
  nand_x1_sg U1526 ( .A(n432), .B(\dma_axi64_dual_core/dma_axi64_reg/n1411 ), 
        .X(n406) );
  nand_x1_sg U1527 ( .A(n367), .B(n368), .X(pslverr) );
  inv_x1_sg U1528 ( .A(\dma_axi64_dual_core/pslverr0 ), .X(n368) );
  inv_x1_sg U1529 ( .A(n400), .X(prdata[0]) );
  inv_x1_sg U1530 ( .A(n389), .X(prdata[1]) );
  inv_x1_sg U1531 ( .A(n378), .X(prdata[2]) );
  inv_x1_sg U1532 ( .A(n375), .X(prdata[3]) );
  inv_x1_sg U1533 ( .A(\dma_axi64_dual_core/prdata0 [4]), .X(n374) );
  inv_x1_sg U1534 ( .A(\dma_axi64_dual_core/prdata0 [5]), .X(n373) );
  inv_x1_sg U1535 ( .A(\dma_axi64_dual_core/prdata0 [6]), .X(n372) );
  inv_x1_sg U1536 ( .A(\dma_axi64_dual_core/prdata0 [7]), .X(n371) );
  inv_x1_sg U1537 ( .A(\dma_axi64_dual_core/prdata0 [8]), .X(n370) );
  inv_x1_sg U1538 ( .A(\dma_axi64_dual_core/prdata0 [9]), .X(n369) );
  inv_x1_sg U1539 ( .A(\dma_axi64_dual_core/prdata0 [10]), .X(n399) );
  inv_x1_sg U1540 ( .A(\dma_axi64_dual_core/prdata0 [11]), .X(n398) );
  inv_x1_sg U1541 ( .A(\dma_axi64_dual_core/prdata0 [12]), .X(n397) );
  inv_x1_sg U1542 ( .A(\dma_axi64_dual_core/prdata0 [13]), .X(n396) );
  inv_x1_sg U1543 ( .A(\dma_axi64_dual_core/prdata0 [14]), .X(n395) );
  inv_x1_sg U1544 ( .A(\dma_axi64_dual_core/prdata0 [15]), .X(n394) );
  inv_x1_sg U1545 ( .A(n393), .X(prdata[16]) );
  inv_x1_sg U1546 ( .A(n392), .X(prdata[17]) );
  inv_x1_sg U1547 ( .A(n391), .X(prdata[18]) );
  inv_x1_sg U1548 ( .A(n390), .X(prdata[19]) );
  inv_x1_sg U1549 ( .A(n388), .X(prdata[20]) );
  inv_x1_sg U1550 ( .A(n387), .X(prdata[21]) );
  inv_x1_sg U1551 ( .A(n386), .X(prdata[22]) );
  inv_x1_sg U1552 ( .A(n385), .X(prdata[23]) );
  inv_x1_sg U1553 ( .A(n384), .X(prdata[24]) );
  inv_x1_sg U1554 ( .A(n383), .X(prdata[25]) );
  inv_x1_sg U1555 ( .A(n382), .X(prdata[26]) );
  inv_x1_sg U1556 ( .A(n381), .X(prdata[27]) );
  inv_x1_sg U1557 ( .A(n380), .X(prdata[28]) );
  inv_x1_sg U1558 ( .A(n379), .X(prdata[29]) );
  inv_x1_sg U1559 ( .A(n377), .X(prdata[30]) );
  inv_x1_sg U1560 ( .A(n376), .X(prdata[31]) );
  nand_x1_sg U1561 ( .A(n693), .B(n694), .X(n1141) );
  nand_x1_sg U1562 ( .A(n695), .B(n1183), .X(n694) );
  nand_x1_sg U1563 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [31]), .B(n1179), .X(n693) );
  nand_x1_sg U1564 ( .A(n697), .B(n698), .X(n1142) );
  nand_x1_sg U1565 ( .A(n699), .B(n1183), .X(n698) );
  nand_x1_sg U1566 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [30]), .B(n1179), .X(n697) );
  nand_x1_sg U1567 ( .A(n685), .B(n686), .X(n1139) );
  nand_x1_sg U1568 ( .A(n687), .B(n1183), .X(n686) );
  nand_x1_sg U1569 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [29]), .B(n1179), .X(n685) );
  nand_x1_sg U1570 ( .A(n637), .B(n638), .X(n1127) );
  nand_x1_sg U1571 ( .A(n639), .B(n1183), .X(n638) );
  nand_x1_sg U1572 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [28]), .B(n1179), .X(n637) );
  nand_x1_sg U1573 ( .A(n641), .B(n642), .X(n1128) );
  nand_x1_sg U1574 ( .A(n643), .B(n1183), .X(n642) );
  nand_x1_sg U1575 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [27]), .B(n1179), .X(n641) );
  nand_x1_sg U1576 ( .A(n625), .B(n626), .X(n1124) );
  nand_x1_sg U1577 ( .A(n627), .B(n1183), .X(n626) );
  nand_x1_sg U1578 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [26]), .B(n1181), .X(n625) );
  nand_x1_sg U1579 ( .A(n629), .B(n630), .X(n1125) );
  nand_x1_sg U1580 ( .A(n631), .B(n1183), .X(n630) );
  nand_x1_sg U1581 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [25]), .B(n1179), .X(n629) );
  nand_x1_sg U1582 ( .A(n661), .B(n662), .X(n1133) );
  nand_x1_sg U1583 ( .A(n663), .B(n1183), .X(n662) );
  nand_x1_sg U1584 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [24]), .B(n1179), .X(n661) );
  nand_x1_sg U1585 ( .A(n665), .B(n666), .X(n1134) );
  nand_x1_sg U1586 ( .A(n667), .B(n1183), .X(n666) );
  nand_x1_sg U1587 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [23]), .B(n1179), .X(n665) );
  nand_x1_sg U1588 ( .A(n649), .B(n650), .X(n1130) );
  nand_x1_sg U1589 ( .A(n651), .B(n1183), .X(n650) );
  nand_x1_sg U1590 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [22]), .B(n1179), .X(n649) );
  nand_x1_sg U1591 ( .A(n653), .B(n654), .X(n1131) );
  nand_x1_sg U1592 ( .A(n655), .B(n1183), .X(n654) );
  nand_x1_sg U1593 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [21]), .B(n1179), .X(n653) );
  nand_x1_sg U1594 ( .A(n621), .B(n622), .X(n1123) );
  nand_x1_sg U1595 ( .A(n623), .B(n1183), .X(n622) );
  nand_x1_sg U1596 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [20]), .B(n1179), .X(n621) );
  nand_x1_sg U1597 ( .A(n645), .B(n646), .X(n1129) );
  nand_x1_sg U1598 ( .A(n647), .B(n1183), .X(n646) );
  nand_x1_sg U1599 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [19]), .B(n1179), .X(n645) );
  nand_x1_sg U1600 ( .A(n657), .B(n658), .X(n1132) );
  nand_x1_sg U1601 ( .A(n659), .B(n1183), .X(n658) );
  nand_x1_sg U1602 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [18]), .B(n1179), .X(n657) );
  nand_x1_sg U1603 ( .A(n725), .B(n726), .X(n1149) );
  nand_x1_sg U1604 ( .A(n727), .B(n1183), .X(n726) );
  nand_x1_sg U1605 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [17]), .B(n1179), .X(n725) );
  nand_x1_sg U1606 ( .A(n729), .B(n730), .X(n1150) );
  nand_x1_sg U1607 ( .A(n731), .B(n1183), .X(n730) );
  nand_x1_sg U1608 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [16]), .B(n1179), .X(n729) );
  nand_x1_sg U1609 ( .A(n713), .B(n714), .X(n1146) );
  nand_x1_sg U1610 ( .A(n715), .B(n1183), .X(n714) );
  nand_x1_sg U1611 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [15]), .B(n1179), .X(n713) );
  nand_x1_sg U1612 ( .A(n717), .B(n718), .X(n1147) );
  nand_x1_sg U1613 ( .A(n719), .B(n1183), .X(n718) );
  nand_x1_sg U1614 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [14]), .B(n1179), .X(n717) );
  nand_x1_sg U1615 ( .A(n677), .B(n678), .X(n1137) );
  nand_x1_sg U1616 ( .A(n679), .B(n1183), .X(n678) );
  nand_x1_sg U1617 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [13]), .B(n1179), .X(n677) );
  nand_x1_sg U1618 ( .A(n689), .B(n690), .X(n1140) );
  nand_x1_sg U1619 ( .A(n691), .B(n1183), .X(n690) );
  nand_x1_sg U1620 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [12]), .B(n1179), .X(n689) );
  nand_x1_sg U1621 ( .A(n613), .B(n614), .X(n1121) );
  nand_x1_sg U1622 ( .A(n615), .B(n1183), .X(n614) );
  nand_x1_sg U1623 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [11]), .B(n1179), .X(n613) );
  nand_x1_sg U1624 ( .A(n617), .B(n618), .X(n1122) );
  nand_x1_sg U1625 ( .A(n619), .B(n1183), .X(n618) );
  nand_x1_sg U1626 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [10]), .B(n1179), .X(n617) );
  nand_x1_sg U1627 ( .A(n701), .B(n702), .X(n1143) );
  nand_x1_sg U1628 ( .A(n703), .B(n1183), .X(n702) );
  nand_x1_sg U1629 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [9]), .B(n1179), 
        .X(n701) );
  nand_x1_sg U1630 ( .A(n607), .B(n608), .X(n1120) );
  nand_x1_sg U1631 ( .A(n609), .B(n1183), .X(n608) );
  nand_x1_sg U1632 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [8]), .B(n1179), 
        .X(n607) );
  nand_x1_sg U1633 ( .A(n669), .B(n670), .X(n1135) );
  nand_x1_sg U1634 ( .A(n671), .B(n1183), .X(n670) );
  nand_x1_sg U1635 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [7]), .B(n1179), 
        .X(n669) );
  nand_x1_sg U1636 ( .A(n705), .B(n706), .X(n1144) );
  nand_x1_sg U1637 ( .A(n707), .B(n1183), .X(n706) );
  nand_x1_sg U1638 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [6]), .B(n1179), 
        .X(n705) );
  nand_x1_sg U1639 ( .A(n721), .B(n722), .X(n1148) );
  nand_x1_sg U1640 ( .A(n723), .B(n1183), .X(n722) );
  nand_x1_sg U1641 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [5]), .B(n1179), 
        .X(n721) );
  nand_x1_sg U1642 ( .A(n673), .B(n674), .X(n1136) );
  nand_x1_sg U1643 ( .A(n675), .B(n1183), .X(n674) );
  nand_x1_sg U1644 ( .A(\dma_axi64_dual_core/periph_rx_req_reg [4]), .B(n1179), 
        .X(n673) );
  nand_x1_sg U1645 ( .A(n709), .B(n710), .X(n1145) );
  nand_x1_sg U1646 ( .A(n711), .B(n1183), .X(n710) );
  nand_x1_sg U1647 ( .A(n1179), .B(\dma_axi64_dual_core/periph_rx_req_reg [3]), 
        .X(n709) );
  nand_x1_sg U1648 ( .A(n681), .B(n682), .X(n1138) );
  nand_x1_sg U1649 ( .A(n683), .B(n1183), .X(n682) );
  nand_x1_sg U1650 ( .A(n1179), .B(\dma_axi64_dual_core/periph_rx_req_reg [2]), 
        .X(n681) );
  nand_x1_sg U1651 ( .A(n633), .B(n634), .X(n1126) );
  nand_x1_sg U1652 ( .A(n635), .B(n1183), .X(n634) );
  nand_x1_sg U1653 ( .A(n1179), .B(\dma_axi64_dual_core/periph_rx_req_reg [1]), 
        .X(n633) );
  nand_x1_sg U1654 ( .A(n557), .B(n558), .X(n1114) );
  nand_x1_sg U1655 ( .A(n559), .B(pwdata[31]), .X(n558) );
  nand_x1_sg U1656 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [31]), .B(n1185), .X(n557) );
  nand_x1_sg U1657 ( .A(n512), .B(n513), .X(n1099) );
  nand_x1_sg U1658 ( .A(n514), .B(pwdata[30]), .X(n513) );
  nand_x1_sg U1659 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [30]), .B(n1185), .X(n512) );
  nand_x1_sg U1660 ( .A(n518), .B(n519), .X(n1101) );
  nand_x1_sg U1661 ( .A(n520), .B(pwdata[29]), .X(n519) );
  nand_x1_sg U1662 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [29]), .B(n1185), .X(n518) );
  nand_x1_sg U1663 ( .A(n515), .B(n516), .X(n1100) );
  nand_x1_sg U1664 ( .A(n517), .B(pwdata[28]), .X(n516) );
  nand_x1_sg U1665 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [28]), .B(n1185), .X(n515) );
  nand_x1_sg U1666 ( .A(n524), .B(n525), .X(n1103) );
  nand_x1_sg U1667 ( .A(n526), .B(pwdata[27]), .X(n525) );
  nand_x1_sg U1668 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [27]), .B(n1185), .X(n524) );
  nand_x1_sg U1669 ( .A(n521), .B(n522), .X(n1102) );
  nand_x1_sg U1670 ( .A(n523), .B(pwdata[26]), .X(n522) );
  nand_x1_sg U1671 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [26]), .B(n1185), .X(n521) );
  nand_x1_sg U1672 ( .A(n530), .B(n531), .X(n1105) );
  nand_x1_sg U1673 ( .A(n532), .B(pwdata[25]), .X(n531) );
  nand_x1_sg U1674 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [25]), .B(n1185), .X(n530) );
  nand_x1_sg U1675 ( .A(n480), .B(n481), .X(n1089) );
  nand_x1_sg U1676 ( .A(n482), .B(pwdata[24]), .X(n481) );
  nand_x1_sg U1677 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [24]), .B(n1187), .X(n480) );
  nand_x1_sg U1678 ( .A(n554), .B(n555), .X(n1113) );
  nand_x1_sg U1679 ( .A(n556), .B(pwdata[23]), .X(n555) );
  nand_x1_sg U1680 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [23]), .B(n1185), .X(n554) );
  nand_x1_sg U1681 ( .A(n551), .B(n552), .X(n1112) );
  nand_x1_sg U1682 ( .A(n553), .B(pwdata[22]), .X(n552) );
  nand_x1_sg U1683 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [22]), .B(n1185), .X(n551) );
  nand_x1_sg U1684 ( .A(n563), .B(n564), .X(n1116) );
  nand_x1_sg U1685 ( .A(n565), .B(pwdata[21]), .X(n564) );
  nand_x1_sg U1686 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [21]), .B(n1185), .X(n563) );
  nand_x1_sg U1687 ( .A(n560), .B(n561), .X(n1115) );
  nand_x1_sg U1688 ( .A(n562), .B(pwdata[20]), .X(n561) );
  nand_x1_sg U1689 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [20]), .B(n1185), .X(n560) );
  nand_x1_sg U1690 ( .A(n536), .B(n537), .X(n1107) );
  nand_x1_sg U1691 ( .A(n538), .B(pwdata[19]), .X(n537) );
  nand_x1_sg U1692 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [19]), .B(n1185), .X(n536) );
  nand_x1_sg U1693 ( .A(n545), .B(n546), .X(n1110) );
  nand_x1_sg U1694 ( .A(n547), .B(pwdata[18]), .X(n546) );
  nand_x1_sg U1695 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [18]), .B(n1185), .X(n545) );
  nand_x1_sg U1696 ( .A(n542), .B(n543), .X(n1109) );
  nand_x1_sg U1697 ( .A(n544), .B(pwdata[17]), .X(n543) );
  nand_x1_sg U1698 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [17]), .B(n1185), .X(n542) );
  nand_x1_sg U1699 ( .A(n503), .B(n504), .X(n1096) );
  nand_x1_sg U1700 ( .A(n505), .B(pwdata[16]), .X(n504) );
  nand_x1_sg U1701 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [16]), .B(n1185), .X(n503) );
  nand_x1_sg U1702 ( .A(n572), .B(n573), .X(n1119) );
  nand_x1_sg U1703 ( .A(n574), .B(pwdata[15]), .X(n573) );
  nand_x1_sg U1704 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [15]), .B(n1185), .X(n572) );
  nand_x1_sg U1705 ( .A(n569), .B(n570), .X(n1118) );
  nand_x1_sg U1706 ( .A(n571), .B(pwdata[14]), .X(n570) );
  nand_x1_sg U1707 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [14]), .B(n1185), .X(n569) );
  nand_x1_sg U1708 ( .A(n566), .B(n567), .X(n1117) );
  nand_x1_sg U1709 ( .A(n568), .B(pwdata[13]), .X(n567) );
  nand_x1_sg U1710 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [13]), .B(n1185), .X(n566) );
  nand_x1_sg U1711 ( .A(n509), .B(n510), .X(n1098) );
  nand_x1_sg U1712 ( .A(n511), .B(pwdata[12]), .X(n510) );
  nand_x1_sg U1713 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [12]), .B(n1185), .X(n509) );
  nand_x1_sg U1714 ( .A(n506), .B(n507), .X(n1097) );
  nand_x1_sg U1715 ( .A(n508), .B(pwdata[11]), .X(n507) );
  nand_x1_sg U1716 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [11]), .B(n1185), .X(n506) );
  nand_x1_sg U1717 ( .A(n500), .B(n501), .X(n1095) );
  nand_x1_sg U1718 ( .A(n502), .B(pwdata[10]), .X(n501) );
  nand_x1_sg U1719 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [10]), .B(n1185), .X(n500) );
  nand_x1_sg U1720 ( .A(n491), .B(n492), .X(n1092) );
  nand_x1_sg U1721 ( .A(n493), .B(pwdata[9]), .X(n492) );
  nand_x1_sg U1722 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [9]), .B(n1185), 
        .X(n491) );
  nand_x1_sg U1723 ( .A(n533), .B(n534), .X(n1106) );
  nand_x1_sg U1724 ( .A(n535), .B(pwdata[8]), .X(n534) );
  nand_x1_sg U1725 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [8]), .B(n1185), 
        .X(n533) );
  nand_x1_sg U1726 ( .A(n548), .B(n549), .X(n1111) );
  nand_x1_sg U1727 ( .A(n550), .B(pwdata[7]), .X(n549) );
  nand_x1_sg U1728 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [7]), .B(n1185), 
        .X(n548) );
  nand_x1_sg U1729 ( .A(n488), .B(n489), .X(n1091) );
  nand_x1_sg U1730 ( .A(n490), .B(pwdata[6]), .X(n489) );
  nand_x1_sg U1731 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [6]), .B(n1185), 
        .X(n488) );
  nand_x1_sg U1732 ( .A(n485), .B(n486), .X(n1090) );
  nand_x1_sg U1733 ( .A(n487), .B(pwdata[5]), .X(n486) );
  nand_x1_sg U1734 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [5]), .B(n1185), 
        .X(n485) );
  nand_x1_sg U1735 ( .A(n497), .B(n498), .X(n1094) );
  nand_x1_sg U1736 ( .A(n499), .B(pwdata[4]), .X(n498) );
  nand_x1_sg U1737 ( .A(\dma_axi64_dual_core/periph_tx_req_reg [4]), .B(n1185), 
        .X(n497) );
  nand_x1_sg U1738 ( .A(n494), .B(n495), .X(n1093) );
  nand_x1_sg U1739 ( .A(n496), .B(pwdata[3]), .X(n495) );
  nand_x1_sg U1740 ( .A(n1185), .B(\dma_axi64_dual_core/periph_tx_req_reg [3]), 
        .X(n494) );
  nand_x1_sg U1741 ( .A(n527), .B(n528), .X(n1104) );
  nand_x1_sg U1742 ( .A(n529), .B(pwdata[2]), .X(n528) );
  nand_x1_sg U1743 ( .A(n1185), .B(\dma_axi64_dual_core/periph_tx_req_reg [2]), 
        .X(n527) );
  nand_x1_sg U1744 ( .A(n539), .B(n540), .X(n1108) );
  nand_x1_sg U1745 ( .A(n541), .B(pwdata[1]), .X(n540) );
  nand_x1_sg U1746 ( .A(n1185), .B(\dma_axi64_dual_core/periph_tx_req_reg [1]), 
        .X(n539) );
  inv_x1_sg U1747 ( .A(n763), .X(n1552) );
  nand_x1_sg U1748 ( .A(n1511), .B(n772), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1347 ) );
  inv_x1_sg U1749 ( .A(n777), .X(n1511) );
  nand_x1_sg U1750 ( .A(n778), .B(n779), .X(n777) );
  nand_x1_sg U1751 ( .A(n1510), .B(n780), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1346 ) );
  inv_x1_sg U1752 ( .A(n785), .X(n1510) );
  nand_x1_sg U1753 ( .A(n786), .B(n787), .X(n785) );
  nand_x1_sg U1754 ( .A(n1509), .B(n788), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1345 ) );
  inv_x1_sg U1755 ( .A(n793), .X(n1509) );
  nand_x1_sg U1756 ( .A(n794), .B(n795), .X(n793) );
  nand_x1_sg U1757 ( .A(n1508), .B(n796), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1344 ) );
  inv_x1_sg U1758 ( .A(n801), .X(n1508) );
  nand_x1_sg U1759 ( .A(n802), .B(n803), .X(n801) );
  nand_x1_sg U1760 ( .A(n1507), .B(n804), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1343 ) );
  inv_x1_sg U1761 ( .A(n809), .X(n1507) );
  nand_x1_sg U1762 ( .A(n810), .B(n811), .X(n809) );
  nand_x1_sg U1763 ( .A(n1506), .B(n812), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1342 ) );
  inv_x1_sg U1764 ( .A(n817), .X(n1506) );
  nand_x1_sg U1765 ( .A(n818), .B(n819), .X(n817) );
  nand_x1_sg U1766 ( .A(n1505), .B(n820), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1341 ) );
  inv_x1_sg U1767 ( .A(n825), .X(n1505) );
  nand_x1_sg U1768 ( .A(n826), .B(n827), .X(n825) );
  nand_x1_sg U1769 ( .A(n1504), .B(n828), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1340 ) );
  inv_x1_sg U1770 ( .A(n833), .X(n1504) );
  nand_x1_sg U1771 ( .A(n834), .B(n835), .X(n833) );
  nand_x1_sg U1772 ( .A(n1503), .B(n836), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1339 ) );
  inv_x1_sg U1773 ( .A(n841), .X(n1503) );
  nand_x1_sg U1774 ( .A(n842), .B(n843), .X(n841) );
  nand_x1_sg U1775 ( .A(n1502), .B(n844), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1338 ) );
  inv_x1_sg U1776 ( .A(n849), .X(n1502) );
  nand_x1_sg U1777 ( .A(n850), .B(n851), .X(n849) );
  nand_x1_sg U1778 ( .A(n1501), .B(n852), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1337 ) );
  inv_x1_sg U1779 ( .A(n857), .X(n1501) );
  nand_x1_sg U1780 ( .A(n858), .B(n859), .X(n857) );
  nand_x1_sg U1781 ( .A(n1500), .B(n860), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1336 ) );
  inv_x1_sg U1782 ( .A(n865), .X(n1500) );
  nand_x1_sg U1783 ( .A(n866), .B(n867), .X(n865) );
  nand_x1_sg U1784 ( .A(n1499), .B(n868), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1335 ) );
  inv_x1_sg U1785 ( .A(n873), .X(n1499) );
  nand_x1_sg U1786 ( .A(n874), .B(n875), .X(n873) );
  nand_x1_sg U1787 ( .A(n1498), .B(n876), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1334 ) );
  inv_x1_sg U1788 ( .A(n881), .X(n1498) );
  nand_x1_sg U1789 ( .A(n882), .B(n883), .X(n881) );
  nand_x1_sg U1790 ( .A(n1497), .B(n884), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1333 ) );
  inv_x1_sg U1791 ( .A(n889), .X(n1497) );
  nand_x1_sg U1792 ( .A(n890), .B(n891), .X(n889) );
  nand_x1_sg U1793 ( .A(n1496), .B(n892), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1332 ) );
  inv_x1_sg U1794 ( .A(n897), .X(n1496) );
  nand_x1_sg U1795 ( .A(n898), .B(n899), .X(n897) );
  nand_x1_sg U1796 ( .A(n900), .B(n901), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1331 ) );
  nand_x1_sg U1797 ( .A(n910), .B(n911), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1330 ) );
  nand_x1_sg U1798 ( .A(n920), .B(n921), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1329 ) );
  nand_x1_sg U1799 ( .A(n930), .B(n931), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1328 ) );
  nand_x1_sg U1800 ( .A(n940), .B(n941), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1327 ) );
  nand_x1_sg U1801 ( .A(n950), .B(n951), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1326 ) );
  nand_x1_sg U1802 ( .A(n960), .B(n961), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1325 ) );
  nand_x1_sg U1803 ( .A(n970), .B(n971), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1324 ) );
  nand_x1_sg U1804 ( .A(n980), .B(n981), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1323 ) );
  nand_x1_sg U1805 ( .A(n992), .B(n993), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1322 ) );
  nand_x1_sg U1806 ( .A(n1004), .B(n1005), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1321 ) );
  nand_x1_sg U1807 ( .A(n1016), .B(n1017), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1320 ) );
  nand_x1_sg U1808 ( .A(n433), .B(n434), .X(n1086) );
  nand_x1_sg U1809 ( .A(n466), .B(n467), .X(n1088) );
  nand_x1_sg U1810 ( .A(n452), .B(n453), .X(n1087) );
  nand_x1_sg U1811 ( .A(n1495), .B(n1040), .X(
        \dma_axi64_dual_core/dma_axi64_reg/n1316 ) );
  inv_x1_sg U1812 ( .A(n1067), .X(n1495) );
  nand_x1_sg U1813 ( .A(n404), .B(n405), .X(n1085) );
  nand_x1_sg U1814 ( .A(n406), .B(n407), .X(n405) );
  nand_x1_sg U1815 ( .A(\dma_axi64_dual_core/pslverr_reg ), .B(n1172), .X(n404) );
  nand_x1_sg U1816 ( .A(n408), .B(n409), .X(n407) );
  nand_x1_sg U1817 ( .A(n401), .B(n1547), .X(n1084) );
  inv_x1_sg U1818 ( .A(n402), .X(n1547) );
  nand_x1_sg U1819 ( .A(pready), .B(n1172), .X(n401) );
  nand_x1_sg U1820 ( .A(n1076), .B(paddr[3]), .X(
        \dma_axi64_dual_core/dma_axi64_reg/N397 ) );
  inv_x1_sg U1821 ( .A(\dma_axi64_dual_core/dma_axi64_apb_mux/n3 ), .X(n1548)
         );
  nor_x2_sg U1822 ( .A(n1030), .B(n1031), .X(n1029) );
  inv_x4_sg U1823 ( .A(n1169), .X(n1170) );
  nor_x2_sg U1824 ( .A(n1541), .B(n430), .X(n431) );
  nand_x2_sg U1825 ( .A(n430), .B(n1032), .X(n1065) );
  inv_x4_sg U1826 ( .A(paddr[2]), .X(n430) );
  inv_x4_sg U1827 ( .A(n1023), .X(n1544) );
  nor_x4_sg U1828 ( .A(n432), .B(n1551), .X(n1023) );
  nor_x2_sg U1829 ( .A(n1545), .B(n1531), .X(n610) );
  inv_x4_sg U1830 ( .A(n1029), .X(n1531) );
  nand_x2_sg U1831 ( .A(n1032), .B(n1541), .X(n1030) );
  inv_x8_sg U1832 ( .A(paddr[3]), .X(n1032) );
  inv_x4_sg U1833 ( .A(n1059), .X(n1494) );
  nor_x4_sg U1834 ( .A(n418), .B(paddr[2]), .X(n1059) );
  nor_x4_sg U1835 ( .A(n432), .B(n1168), .X(n443) );
  nor_x4_sg U1836 ( .A(\dma_axi64_dual_core/dma_axi64_reg/n1411 ), .B(n1551), 
        .X(n599) );
  inv_x8_sg U1837 ( .A(n1079), .X(n1551) );
  nor_x4_sg U1838 ( .A(paddr[5]), .B(paddr[7]), .X(n1028) );
  nor_x2_sg U1839 ( .A(n1543), .B(n423), .X(n410) );
  inv_x4_sg U1840 ( .A(n1027), .X(n1543) );
  nand_x2_sg U1841 ( .A(n1549), .B(n1550), .X(
        \dma_axi64_dual_core/dma_axi64_apb_mux/n8 ) );
  inv_x4_sg U1842 ( .A(paddr[11]), .X(n1550) );
  inv_x4_sg U1843 ( .A(paddr[5]), .X(n422) );
  nor_x8_sg U1844 ( .A(n1549), .B(\dma_axi64_dual_core/dma_axi64_apb_mux/n3 ), 
        .X(n771) );
  inv_x8_sg U1845 ( .A(paddr[12]), .X(n1549) );
  inv_x8_sg U1846 ( .A(n1062), .X(n1513) );
  nand_x4_sg U1847 ( .A(n1063), .B(n1064), .X(n1062) );
  nand_x2_sg U1848 ( .A(n1548), .B(n1549), .X(n1083) );
  nor_x2_sg U1849 ( .A(pclken), .B(n1151), .X(n1036) );
  nor_x2_sg U1850 ( .A(pclken), .B(n1152), .X(n1012) );
  nor_x2_sg U1851 ( .A(pclken), .B(n1153), .X(n1000) );
  nor_x2_sg U1852 ( .A(pclken), .B(n1154), .X(n988) );
  nor_x2_sg U1853 ( .A(pclken), .B(n1155), .X(n976) );
  nor_x2_sg U1854 ( .A(pclken), .B(n1156), .X(n966) );
  nor_x2_sg U1855 ( .A(pclken), .B(n1157), .X(n956) );
  nor_x2_sg U1856 ( .A(pclken), .B(n1158), .X(n946) );
  nor_x2_sg U1857 ( .A(pclken), .B(n1159), .X(n936) );
  nor_x2_sg U1858 ( .A(pclken), .B(n1160), .X(n926) );
  nor_x2_sg U1859 ( .A(pclken), .B(n1161), .X(n916) );
  nor_x2_sg U1860 ( .A(pclken), .B(n1162), .X(n906) );
  inv_x4_sg U1861 ( .A(pclken), .X(n403) );
  nand_x2_sg U1862 ( .A(n1080), .B(n1493), .X(
        \dma_axi64_dual_core/dma_axi64_reg/N380 ) );
  inv_x4_sg U1863 ( .A(n1050), .X(n1493) );
  inv_x4_sg U1864 ( .A(paddr[7]), .X(n419) );
  inv_x8_sg U1865 ( .A(n418), .X(n1541) );
  nor_x1_sg U1866 ( .A(n1544), .B(n1066), .X(n1063) );
  nor_x1_sg U1867 ( .A(n1541), .B(n1065), .X(n1064) );
  nor_x1_sg U1868 ( .A(n1531), .B(n1544), .X(n451) );
  nor_x1_sg U1869 ( .A(n1539), .B(n902), .X(n901) );
  nor_x1_sg U1870 ( .A(n906), .B(n907), .X(n900) );
  nand_x2_sg U1871 ( .A(n903), .B(n904), .X(n902) );
  nor_x1_sg U1872 ( .A(n1538), .B(n912), .X(n911) );
  nor_x1_sg U1873 ( .A(n916), .B(n917), .X(n910) );
  nand_x2_sg U1874 ( .A(n913), .B(n914), .X(n912) );
  nor_x1_sg U1875 ( .A(n1537), .B(n922), .X(n921) );
  nor_x1_sg U1876 ( .A(n926), .B(n927), .X(n920) );
  nand_x2_sg U1877 ( .A(n923), .B(n924), .X(n922) );
  nor_x1_sg U1878 ( .A(n1536), .B(n932), .X(n931) );
  nor_x1_sg U1879 ( .A(n936), .B(n937), .X(n930) );
  nand_x2_sg U1880 ( .A(n933), .B(n934), .X(n932) );
  nor_x1_sg U1881 ( .A(n1535), .B(n942), .X(n941) );
  nor_x1_sg U1882 ( .A(n946), .B(n947), .X(n940) );
  nand_x2_sg U1883 ( .A(n943), .B(n944), .X(n942) );
  nor_x1_sg U1884 ( .A(n1534), .B(n952), .X(n951) );
  nor_x1_sg U1885 ( .A(n956), .B(n957), .X(n950) );
  nand_x2_sg U1886 ( .A(n953), .B(n954), .X(n952) );
  nor_x1_sg U1887 ( .A(n1533), .B(n962), .X(n961) );
  nor_x1_sg U1888 ( .A(n966), .B(n967), .X(n960) );
  nand_x2_sg U1889 ( .A(n963), .B(n964), .X(n962) );
  nor_x1_sg U1890 ( .A(n1532), .B(n972), .X(n971) );
  nor_x1_sg U1891 ( .A(n976), .B(n977), .X(n970) );
  nand_x2_sg U1892 ( .A(n973), .B(n974), .X(n972) );
  nor_x1_sg U1893 ( .A(n982), .B(n983), .X(n981) );
  nor_x1_sg U1894 ( .A(n988), .B(n989), .X(n980) );
  nand_x2_sg U1895 ( .A(n986), .B(n987), .X(n982) );
  nor_x1_sg U1896 ( .A(n994), .B(n995), .X(n993) );
  nor_x1_sg U1897 ( .A(n1000), .B(n1001), .X(n992) );
  nand_x2_sg U1898 ( .A(n998), .B(n999), .X(n994) );
  nor_x1_sg U1899 ( .A(n1006), .B(n1007), .X(n1005) );
  nor_x1_sg U1900 ( .A(n1012), .B(n1013), .X(n1004) );
  nand_x2_sg U1901 ( .A(n1010), .B(n1011), .X(n1006) );
  nor_x1_sg U1902 ( .A(n1018), .B(n1019), .X(n1017) );
  nor_x1_sg U1903 ( .A(n1036), .B(n1037), .X(n1016) );
  nand_x2_sg U1904 ( .A(n1033), .B(n1034), .X(n1018) );
  nor_x1_sg U1905 ( .A(n1526), .B(n805), .X(n804) );
  nor_x1_sg U1906 ( .A(n1525), .B(n813), .X(n812) );
  nor_x1_sg U1907 ( .A(n1524), .B(n821), .X(n820) );
  nor_x1_sg U1908 ( .A(n1523), .B(n829), .X(n828) );
  nor_x1_sg U1909 ( .A(n1522), .B(n837), .X(n836) );
  nor_x1_sg U1910 ( .A(n1521), .B(n845), .X(n844) );
  nor_x1_sg U1911 ( .A(n1520), .B(n853), .X(n852) );
  nor_x1_sg U1912 ( .A(n1519), .B(n861), .X(n860) );
  nor_x1_sg U1913 ( .A(n1518), .B(n869), .X(n868) );
  nor_x1_sg U1914 ( .A(n1517), .B(n877), .X(n876) );
  nor_x1_sg U1915 ( .A(n1516), .B(n885), .X(n884) );
  nor_x1_sg U1916 ( .A(n1515), .B(n893), .X(n892) );
  nor_x1_sg U1917 ( .A(n1530), .B(n773), .X(n772) );
  nor_x1_sg U1918 ( .A(n1529), .B(n781), .X(n780) );
  nor_x1_sg U1919 ( .A(n1528), .B(n789), .X(n788) );
  nor_x1_sg U1920 ( .A(n1527), .B(n797), .X(n796) );
  nor_x1_sg U1921 ( .A(n435), .B(n436), .X(n434) );
  nor_x1_sg U1922 ( .A(n444), .B(n445), .X(n433) );
  nand_x2_sg U1923 ( .A(n440), .B(n441), .X(n435) );
  nor_x1_sg U1924 ( .A(n468), .B(n469), .X(n467) );
  nor_x1_sg U1925 ( .A(n474), .B(n475), .X(n466) );
  nand_x2_sg U1926 ( .A(n472), .B(n473), .X(n468) );
  nor_x1_sg U1927 ( .A(n454), .B(n455), .X(n453) );
  nor_x1_sg U1928 ( .A(n460), .B(n461), .X(n452) );
  nand_x2_sg U1929 ( .A(n458), .B(n459), .X(n454) );
  nor_x1_sg U1930 ( .A(n1512), .B(n1041), .X(n1040) );
  nand_x2_sg U1931 ( .A(n1042), .B(n1043), .X(n1041) );
  nand_x1_sg U1932 ( .A(n1541), .B(n422), .X(n426) );
  nor_x1_sg U1933 ( .A(n1032), .B(n1050), .X(n1049) );
  nor_x1_sg U1934 ( .A(n431), .B(n1551), .X(n408) );
  nand_x2_sg U1935 ( .A(n418), .B(n1079), .X(n1077) );
  nor_x1_sg U1936 ( .A(n1032), .B(n1551), .X(n1075) );
  nand_x2_sg U1937 ( .A(n1028), .B(n1027), .X(n1066) );
  nand_x2_sg U1938 ( .A(n426), .B(n427), .X(n425) );
  nand_x2_sg U1939 ( .A(n430), .B(n419), .X(n424) );
  nand_x1_sg U1940 ( .A(n1170), .B(n1023), .X(n1022) );
  nand_x2_sg U1941 ( .A(n735), .B(n736), .X(n734) );
  nand_x2_sg U1942 ( .A(n577), .B(n578), .X(n576) );
  nand_x1_sg U1943 ( .A(n1494), .B(n422), .X(n421) );
  nand_x2_sg U1944 ( .A(n749), .B(n750), .X(n733) );
  nor_x1_sg U1945 ( .A(n757), .B(n758), .X(n749) );
  nor_x1_sg U1946 ( .A(n751), .B(n752), .X(n750) );
  nand_x2_sg U1947 ( .A(n761), .B(n762), .X(n757) );
  nand_x2_sg U1948 ( .A(n591), .B(n592), .X(n575) );
  nor_x1_sg U1949 ( .A(n601), .B(n602), .X(n591) );
  nor_x1_sg U1950 ( .A(n593), .B(n594), .X(n592) );
  nand_x2_sg U1951 ( .A(n605), .B(n606), .X(n601) );
  nor_x1_sg U1952 ( .A(n764), .B(n765), .X(n763) );
  nand_x2_sg U1953 ( .A(n768), .B(n769), .X(n764) );
  nand_x2_sg U1954 ( .A(n766), .B(n767), .X(n765) );
  nand_x2_sg U1955 ( .A(n449), .B(n450), .X(n444) );
  nand_x1_sg U1956 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[3] ), .B(n1513), .X(n449) );
  nand_x2_sg U1957 ( .A(n478), .B(n479), .X(n474) );
  nand_x1_sg U1958 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[2] ), .B(n1513), .X(n478) );
  nand_x2_sg U1959 ( .A(n464), .B(n465), .X(n460) );
  nand_x1_sg U1960 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[1] ), .B(n1513), .X(n464) );
  nand_x2_sg U1961 ( .A(n462), .B(n463), .X(n461) );
  nand_x2_sg U1962 ( .A(n908), .B(n909), .X(n907) );
  nand_x2_sg U1963 ( .A(n918), .B(n919), .X(n917) );
  nand_x2_sg U1964 ( .A(n928), .B(n929), .X(n927) );
  nand_x2_sg U1965 ( .A(n938), .B(n939), .X(n937) );
  nand_x2_sg U1966 ( .A(n948), .B(n949), .X(n947) );
  nand_x2_sg U1967 ( .A(n958), .B(n959), .X(n957) );
  nand_x2_sg U1968 ( .A(n968), .B(n969), .X(n967) );
  nand_x2_sg U1969 ( .A(n978), .B(n979), .X(n977) );
  nand_x2_sg U1970 ( .A(n806), .B(n807), .X(n805) );
  nand_x2_sg U1971 ( .A(n814), .B(n815), .X(n813) );
  nand_x2_sg U1972 ( .A(n822), .B(n823), .X(n821) );
  nand_x2_sg U1973 ( .A(n830), .B(n831), .X(n829) );
  nand_x2_sg U1974 ( .A(n838), .B(n839), .X(n837) );
  nand_x2_sg U1975 ( .A(n846), .B(n847), .X(n845) );
  nand_x2_sg U1976 ( .A(n854), .B(n855), .X(n853) );
  nand_x2_sg U1977 ( .A(n862), .B(n863), .X(n861) );
  nand_x2_sg U1978 ( .A(n870), .B(n871), .X(n869) );
  nand_x2_sg U1979 ( .A(n878), .B(n879), .X(n877) );
  nand_x2_sg U1980 ( .A(n886), .B(n887), .X(n885) );
  nand_x2_sg U1981 ( .A(n894), .B(n895), .X(n893) );
  nand_x2_sg U1982 ( .A(n984), .B(n985), .X(n983) );
  nand_x2_sg U1983 ( .A(n996), .B(n997), .X(n995) );
  nand_x2_sg U1984 ( .A(n1008), .B(n1009), .X(n1007) );
  nand_x2_sg U1985 ( .A(n1020), .B(n1021), .X(n1019) );
  nand_x2_sg U1986 ( .A(n446), .B(n447), .X(n445) );
  nand_x2_sg U1987 ( .A(n476), .B(n477), .X(n475) );
  nand_x2_sg U1988 ( .A(n774), .B(n775), .X(n773) );
  nand_x2_sg U1989 ( .A(n782), .B(n783), .X(n781) );
  nand_x2_sg U1990 ( .A(n790), .B(n791), .X(n789) );
  nand_x2_sg U1991 ( .A(n798), .B(n799), .X(n797) );
  nand_x2_sg U1992 ( .A(n437), .B(n438), .X(n436) );
  nand_x2_sg U1993 ( .A(n470), .B(n471), .X(n469) );
  nand_x2_sg U1994 ( .A(n456), .B(n457), .X(n455) );
  nor_x1_sg U1995 ( .A(\dma_axi64_dual_core/dma_axi64_apb_mux/n3 ), .B(penable), .X(n402) );
  nor_x1_sg U1996 ( .A(periph_rx_clr[17]), .B(n728), .X(n727) );
  nor_x1_sg U1997 ( .A(periph_rx_clr[16]), .B(n732), .X(n731) );
  nor_x1_sg U1998 ( .A(periph_rx_clr[15]), .B(n716), .X(n715) );
  nor_x1_sg U1999 ( .A(periph_rx_clr[14]), .B(n720), .X(n719) );
  nor_x1_sg U2000 ( .A(periph_rx_clr[9]), .B(n704), .X(n703) );
  nor_x1_sg U2001 ( .A(periph_rx_clr[6]), .B(n708), .X(n707) );
  nor_x1_sg U2002 ( .A(periph_rx_clr[5]), .B(n724), .X(n723) );
  nor_x1_sg U2003 ( .A(periph_rx_clr[3]), .B(n712), .X(n711) );
  nor_x1_sg U2004 ( .A(periph_rx_clr[31]), .B(n696), .X(n695) );
  nor_x1_sg U2005 ( .A(periph_rx_clr[30]), .B(n700), .X(n699) );
  nor_x1_sg U2006 ( .A(periph_rx_clr[29]), .B(n688), .X(n687) );
  nor_x1_sg U2007 ( .A(periph_rx_clr[28]), .B(n640), .X(n639) );
  nor_x1_sg U2008 ( .A(periph_rx_clr[27]), .B(n644), .X(n643) );
  nor_x1_sg U2009 ( .A(periph_rx_clr[25]), .B(n632), .X(n631) );
  nor_x1_sg U2010 ( .A(periph_rx_clr[24]), .B(n664), .X(n663) );
  nor_x1_sg U2011 ( .A(periph_rx_clr[23]), .B(n668), .X(n667) );
  nor_x1_sg U2012 ( .A(periph_rx_clr[22]), .B(n652), .X(n651) );
  nor_x1_sg U2013 ( .A(periph_rx_clr[21]), .B(n656), .X(n655) );
  nor_x1_sg U2014 ( .A(periph_rx_clr[19]), .B(n648), .X(n647) );
  nor_x1_sg U2015 ( .A(periph_rx_clr[18]), .B(n660), .X(n659) );
  nor_x1_sg U2016 ( .A(periph_rx_clr[13]), .B(n680), .X(n679) );
  nor_x1_sg U2017 ( .A(periph_rx_clr[12]), .B(n692), .X(n691) );
  nor_x1_sg U2018 ( .A(periph_rx_clr[7]), .B(n672), .X(n671) );
  nor_x1_sg U2019 ( .A(periph_rx_clr[4]), .B(n676), .X(n675) );
  nor_x1_sg U2020 ( .A(periph_rx_clr[2]), .B(n684), .X(n683) );
  nor_x1_sg U2021 ( .A(periph_rx_clr[1]), .B(n636), .X(n635) );
  nor_x1_sg U2022 ( .A(periph_tx_clr[31]), .B(n483), .X(n559) );
  nor_x1_sg U2023 ( .A(periph_tx_clr[30]), .B(n483), .X(n514) );
  nor_x1_sg U2024 ( .A(periph_tx_clr[29]), .B(n483), .X(n520) );
  nor_x1_sg U2025 ( .A(periph_tx_clr[28]), .B(n483), .X(n517) );
  nor_x1_sg U2026 ( .A(periph_tx_clr[27]), .B(n483), .X(n526) );
  nor_x1_sg U2027 ( .A(periph_tx_clr[26]), .B(n483), .X(n523) );
  nor_x1_sg U2028 ( .A(periph_tx_clr[25]), .B(n483), .X(n532) );
  nor_x1_sg U2029 ( .A(periph_tx_clr[23]), .B(n483), .X(n556) );
  nor_x1_sg U2030 ( .A(periph_tx_clr[22]), .B(n483), .X(n553) );
  nor_x1_sg U2031 ( .A(periph_tx_clr[21]), .B(n483), .X(n565) );
  nor_x1_sg U2032 ( .A(periph_tx_clr[20]), .B(n483), .X(n562) );
  nor_x1_sg U2033 ( .A(periph_tx_clr[19]), .B(n483), .X(n538) );
  nor_x1_sg U2034 ( .A(periph_tx_clr[18]), .B(n483), .X(n547) );
  nor_x1_sg U2035 ( .A(periph_tx_clr[17]), .B(n483), .X(n544) );
  nor_x1_sg U2036 ( .A(periph_tx_clr[16]), .B(n483), .X(n505) );
  nor_x1_sg U2037 ( .A(periph_tx_clr[15]), .B(n483), .X(n574) );
  nor_x1_sg U2038 ( .A(periph_tx_clr[14]), .B(n483), .X(n571) );
  nor_x1_sg U2039 ( .A(periph_tx_clr[13]), .B(n483), .X(n568) );
  nor_x1_sg U2040 ( .A(periph_tx_clr[12]), .B(n483), .X(n511) );
  nor_x1_sg U2041 ( .A(periph_tx_clr[11]), .B(n483), .X(n508) );
  nor_x1_sg U2042 ( .A(periph_tx_clr[8]), .B(n483), .X(n535) );
  nor_x1_sg U2043 ( .A(periph_tx_clr[7]), .B(n483), .X(n550) );
  nor_x1_sg U2044 ( .A(periph_tx_clr[2]), .B(n483), .X(n529) );
  nor_x1_sg U2045 ( .A(periph_tx_clr[1]), .B(n483), .X(n541) );
  nor_x1_sg U2046 ( .A(periph_rx_clr[26]), .B(n628), .X(n627) );
  nor_x1_sg U2047 ( .A(periph_rx_clr[20]), .B(n624), .X(n623) );
  nor_x1_sg U2048 ( .A(periph_rx_clr[11]), .B(n616), .X(n615) );
  nor_x1_sg U2049 ( .A(periph_rx_clr[10]), .B(n620), .X(n619) );
  nor_x1_sg U2050 ( .A(periph_rx_clr[8]), .B(n611), .X(n609) );
  nor_x1_sg U2051 ( .A(periph_tx_clr[24]), .B(n483), .X(n482) );
  nor_x1_sg U2052 ( .A(periph_tx_clr[10]), .B(n483), .X(n502) );
  nor_x1_sg U2053 ( .A(periph_tx_clr[9]), .B(n483), .X(n493) );
  nor_x1_sg U2054 ( .A(periph_tx_clr[6]), .B(n483), .X(n490) );
  nor_x1_sg U2055 ( .A(periph_tx_clr[5]), .B(n483), .X(n487) );
  nor_x1_sg U2056 ( .A(periph_tx_clr[4]), .B(n483), .X(n499) );
  nor_x1_sg U2057 ( .A(periph_tx_clr[3]), .B(n483), .X(n496) );
  nand_x1_sg U2058 ( .A(n374), .B(n1151), .X(prdata[4]) );
  nand_x1_sg U2059 ( .A(n373), .B(n1152), .X(prdata[5]) );
  nand_x1_sg U2060 ( .A(n372), .B(n1153), .X(prdata[6]) );
  nand_x1_sg U2061 ( .A(n371), .B(n1154), .X(prdata[7]) );
  nand_x1_sg U2062 ( .A(n370), .B(n1155), .X(prdata[8]) );
  nand_x1_sg U2063 ( .A(n369), .B(n1156), .X(prdata[9]) );
  nand_x1_sg U2064 ( .A(n399), .B(n1157), .X(prdata[10]) );
  nand_x1_sg U2065 ( .A(n398), .B(n1158), .X(prdata[11]) );
  nand_x1_sg U2066 ( .A(n397), .B(n1159), .X(prdata[12]) );
  nand_x1_sg U2067 ( .A(n396), .B(n1160), .X(prdata[13]) );
  nand_x1_sg U2068 ( .A(n395), .B(n1161), .X(prdata[14]) );
  nand_x1_sg U2069 ( .A(n394), .B(n1162), .X(prdata[15]) );
  nor_x1_sg U2070 ( .A(\dma_axi64_dual_core/pslverr_reg ), .B(
        \dma_axi64_dual_core/pslverr1 ), .X(n367) );
  nor_x1_sg U2071 ( .A(\dma_axi64_dual_core/prdata0 [0]), .B(
        \dma_axi64_dual_core/prdata_reg [0]), .X(n400) );
  nor_x1_sg U2072 ( .A(\dma_axi64_dual_core/prdata0 [1]), .B(
        \dma_axi64_dual_core/prdata_reg [1]), .X(n389) );
  nor_x1_sg U2073 ( .A(\dma_axi64_dual_core/prdata0 [2]), .B(
        \dma_axi64_dual_core/prdata_reg [2]), .X(n378) );
  nor_x1_sg U2074 ( .A(\dma_axi64_dual_core/prdata0 [3]), .B(
        \dma_axi64_dual_core/prdata_reg [3]), .X(n375) );
  nor_x1_sg U2075 ( .A(\dma_axi64_dual_core/prdata0 [16]), .B(
        \dma_axi64_dual_core/prdata_reg [16]), .X(n393) );
  nor_x1_sg U2076 ( .A(\dma_axi64_dual_core/prdata0 [17]), .B(
        \dma_axi64_dual_core/prdata_reg [17]), .X(n392) );
  nor_x1_sg U2077 ( .A(\dma_axi64_dual_core/prdata0 [18]), .B(
        \dma_axi64_dual_core/prdata_reg [18]), .X(n391) );
  nor_x1_sg U2078 ( .A(\dma_axi64_dual_core/prdata0 [19]), .B(
        \dma_axi64_dual_core/prdata_reg [19]), .X(n390) );
  nor_x1_sg U2079 ( .A(\dma_axi64_dual_core/prdata0 [20]), .B(
        \dma_axi64_dual_core/prdata_reg [20]), .X(n388) );
  nor_x1_sg U2080 ( .A(\dma_axi64_dual_core/prdata0 [21]), .B(
        \dma_axi64_dual_core/prdata_reg [21]), .X(n387) );
  nor_x1_sg U2081 ( .A(\dma_axi64_dual_core/prdata0 [22]), .B(
        \dma_axi64_dual_core/prdata_reg [22]), .X(n386) );
  nor_x1_sg U2082 ( .A(\dma_axi64_dual_core/prdata0 [23]), .B(
        \dma_axi64_dual_core/prdata_reg [23]), .X(n385) );
  nor_x1_sg U2083 ( .A(\dma_axi64_dual_core/prdata0 [24]), .B(
        \dma_axi64_dual_core/prdata_reg [24]), .X(n384) );
  nor_x1_sg U2084 ( .A(\dma_axi64_dual_core/prdata0 [25]), .B(
        \dma_axi64_dual_core/prdata_reg [25]), .X(n383) );
  nor_x1_sg U2085 ( .A(\dma_axi64_dual_core/prdata0 [26]), .B(
        \dma_axi64_dual_core/prdata_reg [26]), .X(n382) );
  nor_x1_sg U2086 ( .A(\dma_axi64_dual_core/prdata0 [27]), .B(
        \dma_axi64_dual_core/prdata_reg [27]), .X(n381) );
  nor_x1_sg U2087 ( .A(\dma_axi64_dual_core/prdata0 [28]), .B(
        \dma_axi64_dual_core/prdata_reg [28]), .X(n380) );
  nor_x1_sg U2088 ( .A(\dma_axi64_dual_core/prdata0 [29]), .B(
        \dma_axi64_dual_core/prdata_reg [29]), .X(n379) );
  nor_x1_sg U2089 ( .A(\dma_axi64_dual_core/prdata0 [30]), .B(
        \dma_axi64_dual_core/prdata_reg [30]), .X(n377) );
  nor_x1_sg U2090 ( .A(\dma_axi64_dual_core/prdata0 [31]), .B(
        \dma_axi64_dual_core/prdata_reg [31]), .X(n376) );
  nand_x2_sg U2091 ( .A(paddr[2]), .B(n1028), .X(n1024) );
  nand_x2_sg U2092 ( .A(n1541), .B(n1026), .X(n1025) );
  nor_x1_sg U2093 ( .A(n1027), .B(paddr[3]), .X(n1026) );
  nand_x1_sg U2094 ( .A(n1051), .B(n1032), .X(n1047) );
  nand_x1_sg U2095 ( .A(n1513), .B(
        \dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[0] ), .X(n1061) );
  nand_x1_sg U2096 ( .A(n1543), .B(n414), .X(n413) );
  nand_x1_sg U2097 ( .A(paddr[5]), .B(n419), .X(n415) );
  nor_x1_sg U2098 ( .A(n419), .B(n1544), .X(n1071) );
  nand_x2_sg U2099 ( .A(paddr[5]), .B(n1032), .X(n1073) );
  nand_x2_sg U2100 ( .A(n412), .B(n413), .X(n411) );
  nand_x2_sg U2101 ( .A(n1541), .B(paddr[2]), .X(n1070) );
  nand_x2_sg U2102 ( .A(n1060), .B(paddr[7]), .X(n1057) );
  nand_x2_sg U2103 ( .A(idle), .B(n1059), .X(n1058) );
  nor_x1_sg U2104 ( .A(paddr[5]), .B(n1027), .X(n1060) );
  nor_x1_sg U2105 ( .A(n1541), .B(n1031), .X(n1056) );
  nand_x4_sg U2106 ( .A(n1081), .B(n1082), .X(n1050) );
  nor_x1_sg U2107 ( .A(n422), .B(n1494), .X(n1081) );
  nor_x1_sg U2108 ( .A(paddr[7]), .B(n1543), .X(n1082) );
  nand_x2_sg U2109 ( .A(n990), .B(n991), .X(n989) );
  nand_x1_sg U2110 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[7] ), .B(n1513), .X(n991) );
  nand_x2_sg U2111 ( .A(n1002), .B(n1003), .X(n1001) );
  nand_x1_sg U2112 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[6] ), .B(n1513), .X(n1003) );
  nand_x2_sg U2113 ( .A(n1014), .B(n1015), .X(n1013) );
  nand_x1_sg U2114 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[5] ), .B(n1513), .X(n1015) );
  nand_x2_sg U2115 ( .A(n1038), .B(n1039), .X(n1037) );
  nand_x1_sg U2116 ( .A(\dma_axi64_dual_core/dma_axi64_reg/proc0_int_stat0[4] ), .B(n1513), .X(n1039) );
  nor_x1_sg U2117 ( .A(paddr[5]), .B(paddr[3]), .X(n429) );
  nor_x1_sg U2118 ( .A(paddr[3]), .B(n1551), .X(n1080) );
  nand_x2_sg U2119 ( .A(n741), .B(n742), .X(n737) );
  nand_x2_sg U2120 ( .A(n739), .B(n740), .X(n738) );
  nor_x1_sg U2121 ( .A(periph_rx_clr[26]), .B(periph_rx_clr[27]), .X(n741) );
  nand_x2_sg U2122 ( .A(n747), .B(n748), .X(n743) );
  nand_x2_sg U2123 ( .A(n745), .B(n746), .X(n744) );
  nor_x1_sg U2124 ( .A(periph_rx_clr[4]), .B(periph_rx_clr[5]), .X(n747) );
  nand_x2_sg U2125 ( .A(n583), .B(n584), .X(n579) );
  nand_x2_sg U2126 ( .A(n581), .B(n582), .X(n580) );
  nor_x1_sg U2127 ( .A(periph_tx_clr[26]), .B(periph_tx_clr[27]), .X(n583) );
  nand_x2_sg U2128 ( .A(n589), .B(n590), .X(n585) );
  nand_x2_sg U2129 ( .A(n587), .B(n588), .X(n586) );
  nor_x1_sg U2130 ( .A(periph_tx_clr[4]), .B(periph_tx_clr[5]), .X(n589) );
  nand_x2_sg U2131 ( .A(n755), .B(n756), .X(n751) );
  nor_x1_sg U2132 ( .A(periph_rx_clr[11]), .B(periph_rx_clr[12]), .X(n755) );
  nor_x1_sg U2133 ( .A(n1183), .B(periph_rx_clr[10]), .X(n756) );
  nand_x2_sg U2134 ( .A(n597), .B(n598), .X(n593) );
  nor_x1_sg U2135 ( .A(periph_tx_clr[11]), .B(periph_tx_clr[12]), .X(n597) );
  nor_x1_sg U2136 ( .A(n1189), .B(periph_tx_clr[10]), .X(n598) );
  nor_x1_sg U2137 ( .A(paddr[2]), .B(n1045), .X(n1044) );
  nor_x1_sg U2138 ( .A(n1054), .B(n1514), .X(n1052) );
  nand_x1_sg U2139 ( .A(\dma_axi64_dual_core/joint_mode0 ), .B(n1493), .X(
        n1053) );
  nand_x2_sg U2140 ( .A(n753), .B(n754), .X(n752) );
  nor_x1_sg U2141 ( .A(periph_rx_clr[15]), .B(periph_rx_clr[16]), .X(n753) );
  nor_x1_sg U2142 ( .A(periph_rx_clr[13]), .B(periph_rx_clr[14]), .X(n754) );
  nand_x2_sg U2143 ( .A(n759), .B(n760), .X(n758) );
  nor_x1_sg U2144 ( .A(periph_rx_clr[22]), .B(periph_rx_clr[23]), .X(n759) );
  nor_x1_sg U2145 ( .A(periph_rx_clr[20]), .B(periph_rx_clr[21]), .X(n760) );
  nand_x2_sg U2146 ( .A(n595), .B(n596), .X(n594) );
  nor_x1_sg U2147 ( .A(periph_tx_clr[15]), .B(periph_tx_clr[16]), .X(n595) );
  nor_x1_sg U2148 ( .A(periph_tx_clr[13]), .B(periph_tx_clr[14]), .X(n596) );
  nand_x2_sg U2149 ( .A(n603), .B(n604), .X(n602) );
  nor_x1_sg U2150 ( .A(periph_tx_clr[22]), .B(periph_tx_clr[23]), .X(n603) );
  nor_x1_sg U2151 ( .A(periph_tx_clr[20]), .B(periph_tx_clr[21]), .X(n604) );
  nor_x1_sg U2152 ( .A(periph_rx_req[1]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [1]), .X(
        \dma_axi64_dual_core/n31 ) );
  nor_x1_sg U2153 ( .A(periph_rx_req[2]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [2]), .X(
        \dma_axi64_dual_core/n30 ) );
  nor_x1_sg U2154 ( .A(periph_rx_req[3]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [3]), .X(
        \dma_axi64_dual_core/n29 ) );
  nor_x1_sg U2155 ( .A(periph_rx_req[4]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [4]), .X(
        \dma_axi64_dual_core/n28 ) );
  nor_x1_sg U2156 ( .A(periph_rx_req[5]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [5]), .X(
        \dma_axi64_dual_core/n27 ) );
  nor_x1_sg U2157 ( .A(periph_rx_req[6]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [6]), .X(
        \dma_axi64_dual_core/n26 ) );
  nor_x1_sg U2158 ( .A(periph_rx_req[7]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [7]), .X(
        \dma_axi64_dual_core/n25 ) );
  nor_x1_sg U2159 ( .A(periph_rx_req[8]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [8]), .X(
        \dma_axi64_dual_core/n24 ) );
  nor_x1_sg U2160 ( .A(periph_rx_req[9]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [9]), .X(
        \dma_axi64_dual_core/n23 ) );
  nor_x1_sg U2161 ( .A(periph_rx_req[10]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [10]), .X(
        \dma_axi64_dual_core/n22 ) );
  nor_x1_sg U2162 ( .A(periph_rx_req[11]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [11]), .X(
        \dma_axi64_dual_core/n21 ) );
  nor_x1_sg U2163 ( .A(periph_rx_req[12]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [12]), .X(
        \dma_axi64_dual_core/n20 ) );
  nor_x1_sg U2164 ( .A(periph_rx_req[13]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [13]), .X(
        \dma_axi64_dual_core/n19 ) );
  nor_x1_sg U2165 ( .A(periph_rx_req[14]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [14]), .X(
        \dma_axi64_dual_core/n18 ) );
  nor_x1_sg U2166 ( .A(periph_rx_req[15]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [15]), .X(
        \dma_axi64_dual_core/n17 ) );
  nor_x1_sg U2167 ( .A(periph_rx_req[16]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [16]), .X(
        \dma_axi64_dual_core/n16 ) );
  nor_x1_sg U2168 ( .A(periph_rx_req[17]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [17]), .X(
        \dma_axi64_dual_core/n15 ) );
  nor_x1_sg U2169 ( .A(periph_rx_req[18]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [18]), .X(
        \dma_axi64_dual_core/n14 ) );
  nor_x1_sg U2170 ( .A(periph_rx_req[19]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [19]), .X(
        \dma_axi64_dual_core/n13 ) );
  nor_x1_sg U2171 ( .A(periph_rx_req[20]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [20]), .X(
        \dma_axi64_dual_core/n12 ) );
  nor_x1_sg U2172 ( .A(periph_rx_req[21]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [21]), .X(
        \dma_axi64_dual_core/n11 ) );
  nor_x1_sg U2173 ( .A(periph_rx_req[22]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [22]), .X(
        \dma_axi64_dual_core/n10 ) );
  nor_x1_sg U2174 ( .A(periph_rx_req[23]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [23]), .X(
        \dma_axi64_dual_core/n9 ) );
  nor_x1_sg U2175 ( .A(periph_rx_req[24]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [24]), .X(
        \dma_axi64_dual_core/n8 ) );
  nor_x1_sg U2176 ( .A(periph_rx_req[25]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [25]), .X(
        \dma_axi64_dual_core/n7 ) );
  nor_x1_sg U2177 ( .A(periph_rx_req[26]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [26]), .X(
        \dma_axi64_dual_core/n6 ) );
  nor_x1_sg U2178 ( .A(periph_rx_req[27]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [27]), .X(
        \dma_axi64_dual_core/n5 ) );
  nor_x1_sg U2179 ( .A(periph_rx_req[28]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [28]), .X(
        \dma_axi64_dual_core/n4 ) );
  nor_x1_sg U2180 ( .A(periph_rx_req[29]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [29]), .X(
        \dma_axi64_dual_core/n3 ) );
  nor_x1_sg U2181 ( .A(periph_rx_req[30]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [30]), .X(
        \dma_axi64_dual_core/n2 ) );
  nor_x1_sg U2182 ( .A(periph_rx_req[31]), .B(
        \dma_axi64_dual_core/periph_rx_req_reg [31]), .X(
        \dma_axi64_dual_core/n1 ) );
  nor_x1_sg U2183 ( .A(periph_tx_req[1]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [1]), .X(
        \dma_axi64_dual_core/n62 ) );
  nor_x1_sg U2184 ( .A(periph_tx_req[2]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [2]), .X(
        \dma_axi64_dual_core/n61 ) );
  nor_x1_sg U2185 ( .A(periph_tx_req[3]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [3]), .X(
        \dma_axi64_dual_core/n60 ) );
  nor_x1_sg U2186 ( .A(periph_tx_req[4]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [4]), .X(
        \dma_axi64_dual_core/n59 ) );
  nor_x1_sg U2187 ( .A(periph_tx_req[5]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [5]), .X(
        \dma_axi64_dual_core/n58 ) );
  nor_x1_sg U2188 ( .A(periph_tx_req[6]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [6]), .X(
        \dma_axi64_dual_core/n57 ) );
  nor_x1_sg U2189 ( .A(periph_tx_req[7]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [7]), .X(
        \dma_axi64_dual_core/n56 ) );
  nor_x1_sg U2190 ( .A(periph_tx_req[8]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [8]), .X(
        \dma_axi64_dual_core/n55 ) );
  nor_x1_sg U2191 ( .A(periph_tx_req[9]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [9]), .X(
        \dma_axi64_dual_core/n54 ) );
  nor_x1_sg U2192 ( .A(periph_tx_req[10]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [10]), .X(
        \dma_axi64_dual_core/n53 ) );
  nor_x1_sg U2193 ( .A(periph_tx_req[11]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [11]), .X(
        \dma_axi64_dual_core/n52 ) );
  nor_x1_sg U2194 ( .A(periph_tx_req[12]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [12]), .X(
        \dma_axi64_dual_core/n51 ) );
  nor_x1_sg U2195 ( .A(periph_tx_req[13]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [13]), .X(
        \dma_axi64_dual_core/n50 ) );
  nor_x1_sg U2196 ( .A(periph_tx_req[14]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [14]), .X(
        \dma_axi64_dual_core/n49 ) );
  nor_x1_sg U2197 ( .A(periph_tx_req[15]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [15]), .X(
        \dma_axi64_dual_core/n48 ) );
  nor_x1_sg U2198 ( .A(periph_tx_req[16]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [16]), .X(
        \dma_axi64_dual_core/n47 ) );
  nor_x1_sg U2199 ( .A(periph_tx_req[17]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [17]), .X(
        \dma_axi64_dual_core/n46 ) );
  nor_x1_sg U2200 ( .A(periph_tx_req[18]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [18]), .X(
        \dma_axi64_dual_core/n45 ) );
  nor_x1_sg U2201 ( .A(periph_tx_req[19]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [19]), .X(
        \dma_axi64_dual_core/n44 ) );
  nor_x1_sg U2202 ( .A(periph_tx_req[20]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [20]), .X(
        \dma_axi64_dual_core/n43 ) );
  nor_x1_sg U2203 ( .A(periph_tx_req[21]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [21]), .X(
        \dma_axi64_dual_core/n42 ) );
  nor_x1_sg U2204 ( .A(periph_tx_req[22]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [22]), .X(
        \dma_axi64_dual_core/n41 ) );
  nor_x1_sg U2205 ( .A(periph_tx_req[23]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [23]), .X(
        \dma_axi64_dual_core/n40 ) );
  nor_x1_sg U2206 ( .A(periph_tx_req[24]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [24]), .X(
        \dma_axi64_dual_core/n39 ) );
  nor_x1_sg U2207 ( .A(periph_tx_req[25]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [25]), .X(
        \dma_axi64_dual_core/n38 ) );
  nor_x1_sg U2208 ( .A(periph_tx_req[26]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [26]), .X(
        \dma_axi64_dual_core/n37 ) );
  nor_x1_sg U2209 ( .A(periph_tx_req[27]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [27]), .X(
        \dma_axi64_dual_core/n36 ) );
  nor_x1_sg U2210 ( .A(periph_tx_req[28]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [28]), .X(
        \dma_axi64_dual_core/n35 ) );
  nor_x1_sg U2211 ( .A(periph_tx_req[29]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [29]), .X(
        \dma_axi64_dual_core/n34 ) );
  nor_x1_sg U2212 ( .A(periph_tx_req[30]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [30]), .X(
        \dma_axi64_dual_core/n33 ) );
  nor_x1_sg U2213 ( .A(periph_tx_req[31]), .B(
        \dma_axi64_dual_core/periph_tx_req_reg [31]), .X(
        \dma_axi64_dual_core/n32 ) );
  inv_x8_sg U2214 ( .A(n1171), .X(n1172) );
  inv_x8_sg U2215 ( .A(n1173), .X(n1174) );
  inv_x8_sg U2216 ( .A(n1176), .X(n1175) );
  inv_x8_sg U2217 ( .A(n1180), .X(n1179) );
  inv_x8_sg U2218 ( .A(n1184), .X(n1183) );
  inv_x4_sg U2219 ( .A(n610), .X(n1184) );
  inv_x8_sg U2220 ( .A(n1186), .X(n1185) );
  inv_x8_sg U2221 ( .A(n1191), .X(n1190) );
  inv_x8_sg U2222 ( .A(n1195), .X(n1194) );
  inv_x8_sg U2223 ( .A(n1199), .X(n1198) );
  inv_x2_sg U2515 ( .A(n1061), .X(n1512) );
  inv_x2_sg U2516 ( .A(n1055), .X(n1514) );
  inv_x2_sg U2517 ( .A(n896), .X(n1515) );
  inv_x2_sg U2518 ( .A(n888), .X(n1516) );
  inv_x2_sg U2519 ( .A(n880), .X(n1517) );
  inv_x2_sg U2520 ( .A(n872), .X(n1518) );
  inv_x2_sg U2521 ( .A(n864), .X(n1519) );
  inv_x2_sg U2522 ( .A(n856), .X(n1520) );
  inv_x2_sg U2523 ( .A(n848), .X(n1521) );
  inv_x2_sg U2524 ( .A(n840), .X(n1522) );
  inv_x2_sg U2525 ( .A(n832), .X(n1523) );
  inv_x2_sg U2526 ( .A(n824), .X(n1524) );
  inv_x2_sg U2527 ( .A(n816), .X(n1525) );
  inv_x2_sg U2528 ( .A(n808), .X(n1526) );
  inv_x2_sg U2529 ( .A(n800), .X(n1527) );
  inv_x2_sg U2530 ( .A(n792), .X(n1528) );
  inv_x2_sg U2531 ( .A(n784), .X(n1529) );
  inv_x2_sg U2532 ( .A(n776), .X(n1530) );
  inv_x2_sg U2533 ( .A(n975), .X(n1532) );
  inv_x2_sg U2534 ( .A(n965), .X(n1533) );
  inv_x2_sg U2535 ( .A(n955), .X(n1534) );
  inv_x2_sg U2536 ( .A(n945), .X(n1535) );
  inv_x2_sg U2537 ( .A(n935), .X(n1536) );
  inv_x2_sg U2538 ( .A(n925), .X(n1537) );
  inv_x2_sg U2539 ( .A(n915), .X(n1538) );
  inv_x2_sg U2540 ( .A(n905), .X(n1539) );
  inv_x2_sg U2541 ( .A(n599), .X(n1545) );
  inv_x2_sg U2542 ( .A(n771), .X(n1546) );
endmodule

