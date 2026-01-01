// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


obj_gurps_combat = createHashMap;

#define vd(a,b,c,d) [a,b,c,d]
#define allocSTVal(val,data) obj_gurps_combat set [str val,data]
#define allocSTVal_inArr(vals,data) {allocSTVal(_x,data)} foreach [vals]
#define allocSTVal_inRange_excludeUp(low,up,data) for "_i" from low to (up - 1) do {allocSTVal(_i,data)}

allocSTVal_inArr(1 arg 2,vd(1,-6,1,-5));
allocSTVal_inArr(3 arg 4,vd(1,-5,1,-4));
allocSTVal_inArr(5 arg 6,vd(1,-4,1,-3));
allocSTVal_inArr(7 arg 8,vd(1,-3,1,-2));

allocSTVal(9,vd(1,-2,1,-1));
allocSTVal(10,vd(1,-2,1,0));
allocSTVal(11,vd(1,-1,1,1));
allocSTVal(12,vd(1,-1,1,2));
allocSTVal(13,vd(1,0,2,-1));
allocSTVal(14,vd(1,0,2,0));
allocSTVal(15,vd(1,1,2,1));
allocSTVal(16,vd(1,1,2,2));
allocSTVal(17,vd(1,2,3,-1));
allocSTVal(18,vd(1,2,3,0));
allocSTVal(19,vd(2,-1,3,1));
allocSTVal(20,vd(2,-1,3,2));
allocSTVal(21,vd(2,0,4,-1));
allocSTVal(22,vd(2,0,4,0));
allocSTVal(23,vd(2,1,4,1));
allocSTVal(24,vd(2,1,4,2));
allocSTVal(25,vd(2,2,5,-1));
allocSTVal(26,vd(2,2,5,0));

allocSTVal_inArr(27 arg 28,vd(3,-1,5,1));
allocSTVal_inArr(29 arg 30,vd(3,0,5,2));
allocSTVal_inArr(31 arg 32,vd(3,1,6,-1));
allocSTVal_inArr(33 arg 34,vd(3,2,6,0));
allocSTVal_inArr(35 arg 36,vd(4,-1,6,1));
allocSTVal_inArr(37 arg 38,vd(4,0,6,2));

allocSTVal(39,vd(4,1,7,-1));

allocSTVal_inRange_excludeUp(40,45,vd(4,1,7,-1));
allocSTVal_inRange_excludeUp(45,50,vd(5,0,7,1));
allocSTVal_inRange_excludeUp(50,55,vd(5,2,8,-1));
allocSTVal_inRange_excludeUp(55,60,vd(6,0,8,1));
allocSTVal_inRange_excludeUp(60,65,vd(7,-1,9,0));
allocSTVal_inRange_excludeUp(65,70,vd(7,1,9,2));
allocSTVal_inRange_excludeUp(70,75,vd(8,0,10,0));
allocSTVal_inRange_excludeUp(75,80,vd(8,2,10,2));
allocSTVal_inRange_excludeUp(80,85,vd(9,0,11,0));
allocSTVal_inRange_excludeUp(85,90,vd(9,2,11,2));
allocSTVal_inRange_excludeUp(90,95,vd(10,0,12,0));
allocSTVal_inRange_excludeUp(95,100,vd(10,2,12,2));
allocSTVal(100,vd(11,0,13,0));