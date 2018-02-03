/**
 Using MINIM AudioInput, get funky with live microphone data
 **/

import ddf.minim.*;
import fixlib.*;

Fixlib fix = Fixlib.init(this);
Minim minim;
AudioInput in;

Boolean isFinal = true;
int buf;
float alf = 37, tX, tY, inLeft, inRight, wvStart,i;


////  CIRCLEY THING
float cX, cY, inc, m; 
float r, g, b;
int tmr_Interval = 10;  // seconds

float x, y, angle, sz=75;
float x2, y2, angle2, sz2; 
float x3, y3, angle3, sz3; 
float x4, y4, angle4, sz4; 


/////////////////////////////////////////////////////////////////////////////////
void setup()
{
  size(1024, 768);
  background(#efefef); 
  noFill();
  ellipseMode(CENTER);
  rectMode(CENTER); 
  strokeCap(ROUND); 
  strokeJoin(ROUND);
  textFont( createFont( "AnonymousPro", 22 ) );
  
  cX = width/2;
  cY = height/2;
  sz = 100;
  sz2 = 109;
  sz3 = 150;
  sz4 = 185;


  y = cY;

  minim = new Minim(this);

  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}

/////////////////////////////////////////////////////////////////
void draw()
{
    smooth();

  // start out getting the noise in sync with frameCount, then random
  buf = ( frameCount < ( in.bufferSize() - 1 ) ) ? frameCount : (int)random(in.bufferSize() - 1);
  inLeft = in.left.get(buf) * frameCount;
  inRight = in.right.get(buf) * frameCount;

strokeWeight(1);
stroke(random(37),random(255),random(75));
wvStart = cX - 512;


/////////////////////////////////////////////////////////////////////
//  COPY AND PASTE CODE FROM CodeWriter.pde
/////////////////////////////////////////////////////////////////////

point( wvStart+buf+in.left.get(0) * frameCount, cY+in.right.get(0) * frameCount );
//  
point( wvStart+buf+in.right.get(1) * frameCount, cY+in.left.get(1) * frameCount);
//  
point( wvStart+buf+in.left.get(2) * frameCount, cY+in.right.get(2) * frameCount );
//  
point( wvStart+buf+in.right.get(3) * frameCount, cY+in.left.get(3) * frameCount);
//  
point( wvStart+buf+in.left.get(4) * frameCount, cY+in.right.get(4) * frameCount );
//  
point( wvStart+buf+in.right.get(5) * frameCount, cY+in.left.get(5) * frameCount);
//  
point( wvStart+buf+in.left.get(6) * frameCount, cY+in.right.get(6) * frameCount );
//  
point( wvStart+buf+in.right.get(7) * frameCount, cY+in.left.get(7) * frameCount);
//  
point( wvStart+buf+in.left.get(8) * frameCount, cY+in.right.get(8) * frameCount );
//  
point( wvStart+buf+in.right.get(9) * frameCount, cY+in.left.get(9) * frameCount);
//  
point( wvStart+buf+in.left.get(10) * frameCount, cY+in.right.get(10) * frameCount );
//  
point( wvStart+buf+in.right.get(11) * frameCount, cY+in.left.get(11) * frameCount);
//  
point( wvStart+buf+in.left.get(12) * frameCount, cY+in.right.get(12) * frameCount );
//  
point( wvStart+buf+in.right.get(13) * frameCount, cY+in.left.get(13) * frameCount);
//  
point( wvStart+buf+in.left.get(14) * frameCount, cY+in.right.get(14) * frameCount );
//  
point( wvStart+buf+in.right.get(15) * frameCount, cY+in.left.get(15) * frameCount);
//  
point( wvStart+buf+in.left.get(16) * frameCount, cY+in.right.get(16) * frameCount );
//  
point( wvStart+buf+in.right.get(17) * frameCount, cY+in.left.get(17) * frameCount);
//  
point( wvStart+buf+in.left.get(18) * frameCount, cY+in.right.get(18) * frameCount );
//  
point( wvStart+buf+in.right.get(19) * frameCount, cY+in.left.get(19) * frameCount);
//  
point( wvStart+buf+in.left.get(20) * frameCount, cY+in.right.get(20) * frameCount );
//  
point( wvStart+buf+in.right.get(21) * frameCount, cY+in.left.get(21) * frameCount);
//  
point( wvStart+buf+in.left.get(22) * frameCount, cY+in.right.get(22) * frameCount );
//  
point( wvStart+buf+in.right.get(23) * frameCount, cY+in.left.get(23) * frameCount);
//  
point( wvStart+buf+in.left.get(24) * frameCount, cY+in.right.get(24) * frameCount );
//  
point( wvStart+buf+in.right.get(25) * frameCount, cY+in.left.get(25) * frameCount);
//  
point( wvStart+buf+in.left.get(26) * frameCount, cY+in.right.get(26) * frameCount );
//  
point( wvStart+buf+in.right.get(27) * frameCount, cY+in.left.get(27) * frameCount);
//  
point( wvStart+buf+in.left.get(28) * frameCount, cY+in.right.get(28) * frameCount );
//  
point( wvStart+buf+in.right.get(29) * frameCount, cY+in.left.get(29) * frameCount);
//  
point( wvStart+buf+in.left.get(30) * frameCount, cY+in.right.get(30) * frameCount );
//  
point( wvStart+buf+in.right.get(31) * frameCount, cY+in.left.get(31) * frameCount);
//  
point( wvStart+buf+in.left.get(32) * frameCount, cY+in.right.get(32) * frameCount );
//  
point( wvStart+buf+in.right.get(33) * frameCount, cY+in.left.get(33) * frameCount);
//  
point( wvStart+buf+in.left.get(34) * frameCount, cY+in.right.get(34) * frameCount );
//  
point( wvStart+buf+in.right.get(35) * frameCount, cY+in.left.get(35) * frameCount);
//  
point( wvStart+buf+in.left.get(36) * frameCount, cY+in.right.get(36) * frameCount );
//  
point( wvStart+buf+in.right.get(37) * frameCount, cY+in.left.get(37) * frameCount);
//  
point( wvStart+buf+in.left.get(38) * frameCount, cY+in.right.get(38) * frameCount );
//  
point( wvStart+buf+in.right.get(39) * frameCount, cY+in.left.get(39) * frameCount);
//  
point( wvStart+buf+in.left.get(40) * frameCount, cY+in.right.get(40) * frameCount );
//  
point( wvStart+buf+in.right.get(41) * frameCount, cY+in.left.get(41) * frameCount);
//  
point( wvStart+buf+in.left.get(42) * frameCount, cY+in.right.get(42) * frameCount );
//  
point( wvStart+buf+in.right.get(43) * frameCount, cY+in.left.get(43) * frameCount);
//  
point( wvStart+buf+in.left.get(44) * frameCount, cY+in.right.get(44) * frameCount );
//  
point( wvStart+buf+in.right.get(45) * frameCount, cY+in.left.get(45) * frameCount);
//  
point( wvStart+buf+in.left.get(46) * frameCount, cY+in.right.get(46) * frameCount );
//  
point( wvStart+buf+in.right.get(47) * frameCount, cY+in.left.get(47) * frameCount);
//  
point( wvStart+buf+in.left.get(48) * frameCount, cY+in.right.get(48) * frameCount );
//  
point( wvStart+buf+in.right.get(49) * frameCount, cY+in.left.get(49) * frameCount);
//  
point( wvStart+buf+in.left.get(50) * frameCount, cY+in.right.get(50) * frameCount );
//  
point( wvStart+buf+in.right.get(51) * frameCount, cY+in.left.get(51) * frameCount);
//  
point( wvStart+buf+in.left.get(52) * frameCount, cY+in.right.get(52) * frameCount );
//  
point( wvStart+buf+in.right.get(53) * frameCount, cY+in.left.get(53) * frameCount);
//  
point( wvStart+buf+in.left.get(54) * frameCount, cY+in.right.get(54) * frameCount );
//  
point( wvStart+buf+in.right.get(55) * frameCount, cY+in.left.get(55) * frameCount);
//  
point( wvStart+buf+in.left.get(56) * frameCount, cY+in.right.get(56) * frameCount );
//  
point( wvStart+buf+in.right.get(57) * frameCount, cY+in.left.get(57) * frameCount);
//  
point( wvStart+buf+in.left.get(58) * frameCount, cY+in.right.get(58) * frameCount );
//  
point( wvStart+buf+in.right.get(59) * frameCount, cY+in.left.get(59) * frameCount);
//  
point( wvStart+buf+in.left.get(60) * frameCount, cY+in.right.get(60) * frameCount );
//  
point( wvStart+buf+in.right.get(61) * frameCount, cY+in.left.get(61) * frameCount);
//  
point( wvStart+buf+in.left.get(62) * frameCount, cY+in.right.get(62) * frameCount );
//  
point( wvStart+buf+in.right.get(63) * frameCount, cY+in.left.get(63) * frameCount);
//  
point( wvStart+buf+in.left.get(64) * frameCount, cY+in.right.get(64) * frameCount );
//  
point( wvStart+buf+in.right.get(65) * frameCount, cY+in.left.get(65) * frameCount);
//  
point( wvStart+buf+in.left.get(66) * frameCount, cY+in.right.get(66) * frameCount );
//  
point( wvStart+buf+in.right.get(67) * frameCount, cY+in.left.get(67) * frameCount);
//  
point( wvStart+buf+in.left.get(68) * frameCount, cY+in.right.get(68) * frameCount );
//  
point( wvStart+buf+in.right.get(69) * frameCount, cY+in.left.get(69) * frameCount);
//  
point( wvStart+buf+in.left.get(70) * frameCount, cY+in.right.get(70) * frameCount );
//  
point( wvStart+buf+in.right.get(71) * frameCount, cY+in.left.get(71) * frameCount);
//  
point( wvStart+buf+in.left.get(72) * frameCount, cY+in.right.get(72) * frameCount );
//  
point( wvStart+buf+in.right.get(73) * frameCount, cY+in.left.get(73) * frameCount);
//  
point( wvStart+buf+in.left.get(74) * frameCount, cY+in.right.get(74) * frameCount );
//  
point( wvStart+buf+in.right.get(75) * frameCount, cY+in.left.get(75) * frameCount);
//  
point( wvStart+buf+in.left.get(76) * frameCount, cY+in.right.get(76) * frameCount );
//  
point( wvStart+buf+in.right.get(77) * frameCount, cY+in.left.get(77) * frameCount);
//  
point( wvStart+buf+in.left.get(78) * frameCount, cY+in.right.get(78) * frameCount );
//  
point( wvStart+buf+in.right.get(79) * frameCount, cY+in.left.get(79) * frameCount);
//  
point( wvStart+buf+in.left.get(80) * frameCount, cY+in.right.get(80) * frameCount );
//  
point( wvStart+buf+in.right.get(81) * frameCount, cY+in.left.get(81) * frameCount);
//  
point( wvStart+buf+in.left.get(82) * frameCount, cY+in.right.get(82) * frameCount );
//  
point( wvStart+buf+in.right.get(83) * frameCount, cY+in.left.get(83) * frameCount);
//  
point( wvStart+buf+in.left.get(84) * frameCount, cY+in.right.get(84) * frameCount );
//  
point( wvStart+buf+in.right.get(85) * frameCount, cY+in.left.get(85) * frameCount);
//  
point( wvStart+buf+in.left.get(86) * frameCount, cY+in.right.get(86) * frameCount );
//  
point( wvStart+buf+in.right.get(87) * frameCount, cY+in.left.get(87) * frameCount);
//  
point( wvStart+buf+in.left.get(88) * frameCount, cY+in.right.get(88) * frameCount );
//  
point( wvStart+buf+in.right.get(89) * frameCount, cY+in.left.get(89) * frameCount);
//  
point( wvStart+buf+in.left.get(90) * frameCount, cY+in.right.get(90) * frameCount );
//  
point( wvStart+buf+in.right.get(91) * frameCount, cY+in.left.get(91) * frameCount);
//  
point( wvStart+buf+in.left.get(92) * frameCount, cY+in.right.get(92) * frameCount );
//  
point( wvStart+buf+in.right.get(93) * frameCount, cY+in.left.get(93) * frameCount);
//  
point( wvStart+buf+in.left.get(94) * frameCount, cY+in.right.get(94) * frameCount );
//  
point( wvStart+buf+in.right.get(95) * frameCount, cY+in.left.get(95) * frameCount);
//  
point( wvStart+buf+in.left.get(96) * frameCount, cY+in.right.get(96) * frameCount );
//  
point( wvStart+buf+in.right.get(97) * frameCount, cY+in.left.get(97) * frameCount);
//  
point( wvStart+buf+in.left.get(98) * frameCount, cY+in.right.get(98) * frameCount );
//  
point( wvStart+buf+in.right.get(99) * frameCount, cY+in.left.get(99) * frameCount);
//  
point( wvStart+buf+in.left.get(100) * frameCount, cY+in.right.get(100) * frameCount );
//  
point( wvStart+buf+in.right.get(101) * frameCount, cY+in.left.get(101) * frameCount);
//  
point( wvStart+buf+in.left.get(102) * frameCount, cY+in.right.get(102) * frameCount );
//  
point( wvStart+buf+in.right.get(103) * frameCount, cY+in.left.get(103) * frameCount);
//  
point( wvStart+buf+in.left.get(104) * frameCount, cY+in.right.get(104) * frameCount );
//  
point( wvStart+buf+in.right.get(105) * frameCount, cY+in.left.get(105) * frameCount);
//  
point( wvStart+buf+in.left.get(106) * frameCount, cY+in.right.get(106) * frameCount );
//  
point( wvStart+buf+in.right.get(107) * frameCount, cY+in.left.get(107) * frameCount);
//  
point( wvStart+buf+in.left.get(108) * frameCount, cY+in.right.get(108) * frameCount );
//  
point( wvStart+buf+in.right.get(109) * frameCount, cY+in.left.get(109) * frameCount);
//  
point( wvStart+buf+in.left.get(110) * frameCount, cY+in.right.get(110) * frameCount );
//  
point( wvStart+buf+in.right.get(111) * frameCount, cY+in.left.get(111) * frameCount);
//  
point( wvStart+buf+in.left.get(112) * frameCount, cY+in.right.get(112) * frameCount );
//  
point( wvStart+buf+in.right.get(113) * frameCount, cY+in.left.get(113) * frameCount);
//  
point( wvStart+buf+in.left.get(114) * frameCount, cY+in.right.get(114) * frameCount );
//  
point( wvStart+buf+in.right.get(115) * frameCount, cY+in.left.get(115) * frameCount);
//  
point( wvStart+buf+in.left.get(116) * frameCount, cY+in.right.get(116) * frameCount );
//  
point( wvStart+buf+in.right.get(117) * frameCount, cY+in.left.get(117) * frameCount);
//  
point( wvStart+buf+in.left.get(118) * frameCount, cY+in.right.get(118) * frameCount );
//  
point( wvStart+buf+in.right.get(119) * frameCount, cY+in.left.get(119) * frameCount);
//  
point( wvStart+buf+in.left.get(120) * frameCount, cY+in.right.get(120) * frameCount );
//  
point( wvStart+buf+in.right.get(121) * frameCount, cY+in.left.get(121) * frameCount);
//  
point( wvStart+buf+in.left.get(122) * frameCount, cY+in.right.get(122) * frameCount );
//  
point( wvStart+buf+in.right.get(123) * frameCount, cY+in.left.get(123) * frameCount);
//  
point( wvStart+buf+in.left.get(124) * frameCount, cY+in.right.get(124) * frameCount );
//  
point( wvStart+buf+in.right.get(125) * frameCount, cY+in.left.get(125) * frameCount);
//  
point( wvStart+buf+in.left.get(126) * frameCount, cY+in.right.get(126) * frameCount );
//  
point( wvStart+buf+in.right.get(127) * frameCount, cY+in.left.get(127) * frameCount);
//  
point( wvStart+buf+in.left.get(128) * frameCount, cY+in.right.get(128) * frameCount );
//  
point( wvStart+buf+in.right.get(129) * frameCount, cY+in.left.get(129) * frameCount);
//  
point( wvStart+buf+in.left.get(130) * frameCount, cY+in.right.get(130) * frameCount );
//  
point( wvStart+buf+in.right.get(131) * frameCount, cY+in.left.get(131) * frameCount);
//  
point( wvStart+buf+in.left.get(132) * frameCount, cY+in.right.get(132) * frameCount );
//  
point( wvStart+buf+in.right.get(133) * frameCount, cY+in.left.get(133) * frameCount);
//  
point( wvStart+buf+in.left.get(134) * frameCount, cY+in.right.get(134) * frameCount );
//  
point( wvStart+buf+in.right.get(135) * frameCount, cY+in.left.get(135) * frameCount);
//  
point( wvStart+buf+in.left.get(136) * frameCount, cY+in.right.get(136) * frameCount );
//  
point( wvStart+buf+in.right.get(137) * frameCount, cY+in.left.get(137) * frameCount);
//  
point( wvStart+buf+in.left.get(138) * frameCount, cY+in.right.get(138) * frameCount );
//  
point( wvStart+buf+in.right.get(139) * frameCount, cY+in.left.get(139) * frameCount);
//  
point( wvStart+buf+in.left.get(140) * frameCount, cY+in.right.get(140) * frameCount );
//  
point( wvStart+buf+in.right.get(141) * frameCount, cY+in.left.get(141) * frameCount);
//  
point( wvStart+buf+in.left.get(142) * frameCount, cY+in.right.get(142) * frameCount );
//  
point( wvStart+buf+in.right.get(143) * frameCount, cY+in.left.get(143) * frameCount);
//  
point( wvStart+buf+in.left.get(144) * frameCount, cY+in.right.get(144) * frameCount );
//  
point( wvStart+buf+in.right.get(145) * frameCount, cY+in.left.get(145) * frameCount);
//  
point( wvStart+buf+in.left.get(146) * frameCount, cY+in.right.get(146) * frameCount );
//  
point( wvStart+buf+in.right.get(147) * frameCount, cY+in.left.get(147) * frameCount);
//  
point( wvStart+buf+in.left.get(148) * frameCount, cY+in.right.get(148) * frameCount );
//  
point( wvStart+buf+in.right.get(149) * frameCount, cY+in.left.get(149) * frameCount);
//  
point( wvStart+buf+in.left.get(150) * frameCount, cY+in.right.get(150) * frameCount );
//  
point( wvStart+buf+in.right.get(151) * frameCount, cY+in.left.get(151) * frameCount);
//  
point( wvStart+buf+in.left.get(152) * frameCount, cY+in.right.get(152) * frameCount );
//  
point( wvStart+buf+in.right.get(153) * frameCount, cY+in.left.get(153) * frameCount);
//  
point( wvStart+buf+in.left.get(154) * frameCount, cY+in.right.get(154) * frameCount );
//  
point( wvStart+buf+in.right.get(155) * frameCount, cY+in.left.get(155) * frameCount);
//  
point( wvStart+buf+in.left.get(156) * frameCount, cY+in.right.get(156) * frameCount );
//  
point( wvStart+buf+in.right.get(157) * frameCount, cY+in.left.get(157) * frameCount);
//  
point( wvStart+buf+in.left.get(158) * frameCount, cY+in.right.get(158) * frameCount );
//  
point( wvStart+buf+in.right.get(159) * frameCount, cY+in.left.get(159) * frameCount);
//  
point( wvStart+buf+in.left.get(160) * frameCount, cY+in.right.get(160) * frameCount );
//  
point( wvStart+buf+in.right.get(161) * frameCount, cY+in.left.get(161) * frameCount);
//  
point( wvStart+buf+in.left.get(162) * frameCount, cY+in.right.get(162) * frameCount );
//  
point( wvStart+buf+in.right.get(163) * frameCount, cY+in.left.get(163) * frameCount);
//  
point( wvStart+buf+in.left.get(164) * frameCount, cY+in.right.get(164) * frameCount );
//  
point( wvStart+buf+in.right.get(165) * frameCount, cY+in.left.get(165) * frameCount);
//  
point( wvStart+buf+in.left.get(166) * frameCount, cY+in.right.get(166) * frameCount );
//  
point( wvStart+buf+in.right.get(167) * frameCount, cY+in.left.get(167) * frameCount);
//  
point( wvStart+buf+in.left.get(168) * frameCount, cY+in.right.get(168) * frameCount );
//  
point( wvStart+buf+in.right.get(169) * frameCount, cY+in.left.get(169) * frameCount);
//  
point( wvStart+buf+in.left.get(170) * frameCount, cY+in.right.get(170) * frameCount );
//  
point( wvStart+buf+in.right.get(171) * frameCount, cY+in.left.get(171) * frameCount);
//  
point( wvStart+buf+in.left.get(172) * frameCount, cY+in.right.get(172) * frameCount );
//  
point( wvStart+buf+in.right.get(173) * frameCount, cY+in.left.get(173) * frameCount);
//  
point( wvStart+buf+in.left.get(174) * frameCount, cY+in.right.get(174) * frameCount );
//  
point( wvStart+buf+in.right.get(175) * frameCount, cY+in.left.get(175) * frameCount);
//  
point( wvStart+buf+in.left.get(176) * frameCount, cY+in.right.get(176) * frameCount );
//  
point( wvStart+buf+in.right.get(177) * frameCount, cY+in.left.get(177) * frameCount);
//  
point( wvStart+buf+in.left.get(178) * frameCount, cY+in.right.get(178) * frameCount );
//  
point( wvStart+buf+in.right.get(179) * frameCount, cY+in.left.get(179) * frameCount);
//  
point( wvStart+buf+in.left.get(180) * frameCount, cY+in.right.get(180) * frameCount );
//  
point( wvStart+buf+in.right.get(181) * frameCount, cY+in.left.get(181) * frameCount);
//  
point( wvStart+buf+in.left.get(182) * frameCount, cY+in.right.get(182) * frameCount );
//  
point( wvStart+buf+in.right.get(183) * frameCount, cY+in.left.get(183) * frameCount);
//  
point( wvStart+buf+in.left.get(184) * frameCount, cY+in.right.get(184) * frameCount );
//  
point( wvStart+buf+in.right.get(185) * frameCount, cY+in.left.get(185) * frameCount);
//  
point( wvStart+buf+in.left.get(186) * frameCount, cY+in.right.get(186) * frameCount );
//  
point( wvStart+buf+in.right.get(187) * frameCount, cY+in.left.get(187) * frameCount);
//  
point( wvStart+buf+in.left.get(188) * frameCount, cY+in.right.get(188) * frameCount );
//  
point( wvStart+buf+in.right.get(189) * frameCount, cY+in.left.get(189) * frameCount);
//  
point( wvStart+buf+in.left.get(190) * frameCount, cY+in.right.get(190) * frameCount );
//  
point( wvStart+buf+in.right.get(191) * frameCount, cY+in.left.get(191) * frameCount);
//  
point( wvStart+buf+in.left.get(192) * frameCount, cY+in.right.get(192) * frameCount );
//  
point( wvStart+buf+in.right.get(193) * frameCount, cY+in.left.get(193) * frameCount);
//  
point( wvStart+buf+in.left.get(194) * frameCount, cY+in.right.get(194) * frameCount );
//  
point( wvStart+buf+in.right.get(195) * frameCount, cY+in.left.get(195) * frameCount);
//  
point( wvStart+buf+in.left.get(196) * frameCount, cY+in.right.get(196) * frameCount );
//  
point( wvStart+buf+in.right.get(197) * frameCount, cY+in.left.get(197) * frameCount);
//  
point( wvStart+buf+in.left.get(198) * frameCount, cY+in.right.get(198) * frameCount );
//  
point( wvStart+buf+in.right.get(199) * frameCount, cY+in.left.get(199) * frameCount);
//  
point( wvStart+buf+in.left.get(200) * frameCount, cY+in.right.get(200) * frameCount );
//  
point( wvStart+buf+in.right.get(201) * frameCount, cY+in.left.get(201) * frameCount);
//  
point( wvStart+buf+in.left.get(202) * frameCount, cY+in.right.get(202) * frameCount );
//  
point( wvStart+buf+in.right.get(203) * frameCount, cY+in.left.get(203) * frameCount);
//  
point( wvStart+buf+in.left.get(204) * frameCount, cY+in.right.get(204) * frameCount );
//  
point( wvStart+buf+in.right.get(205) * frameCount, cY+in.left.get(205) * frameCount);
//  
point( wvStart+buf+in.left.get(206) * frameCount, cY+in.right.get(206) * frameCount );
//  
point( wvStart+buf+in.right.get(207) * frameCount, cY+in.left.get(207) * frameCount);
//  
point( wvStart+buf+in.left.get(208) * frameCount, cY+in.right.get(208) * frameCount );
//  
point( wvStart+buf+in.right.get(209) * frameCount, cY+in.left.get(209) * frameCount);
//  
point( wvStart+buf+in.left.get(210) * frameCount, cY+in.right.get(210) * frameCount );
//  
point( wvStart+buf+in.right.get(211) * frameCount, cY+in.left.get(211) * frameCount);
//  
point( wvStart+buf+in.left.get(212) * frameCount, cY+in.right.get(212) * frameCount );
//  
point( wvStart+buf+in.right.get(213) * frameCount, cY+in.left.get(213) * frameCount);
//  
point( wvStart+buf+in.left.get(214) * frameCount, cY+in.right.get(214) * frameCount );
//  
point( wvStart+buf+in.right.get(215) * frameCount, cY+in.left.get(215) * frameCount);
//  
point( wvStart+buf+in.left.get(216) * frameCount, cY+in.right.get(216) * frameCount );
//  
point( wvStart+buf+in.right.get(217) * frameCount, cY+in.left.get(217) * frameCount);
//  
point( wvStart+buf+in.left.get(218) * frameCount, cY+in.right.get(218) * frameCount );
//  
point( wvStart+buf+in.right.get(219) * frameCount, cY+in.left.get(219) * frameCount);
//  
point( wvStart+buf+in.left.get(220) * frameCount, cY+in.right.get(220) * frameCount );
//  
point( wvStart+buf+in.right.get(221) * frameCount, cY+in.left.get(221) * frameCount);
//  
point( wvStart+buf+in.left.get(222) * frameCount, cY+in.right.get(222) * frameCount );
//  
point( wvStart+buf+in.right.get(223) * frameCount, cY+in.left.get(223) * frameCount);
//  
point( wvStart+buf+in.left.get(224) * frameCount, cY+in.right.get(224) * frameCount );
//  
point( wvStart+buf+in.right.get(225) * frameCount, cY+in.left.get(225) * frameCount);
//  
point( wvStart+buf+in.left.get(226) * frameCount, cY+in.right.get(226) * frameCount );
//  
point( wvStart+buf+in.right.get(227) * frameCount, cY+in.left.get(227) * frameCount);
//  
point( wvStart+buf+in.left.get(228) * frameCount, cY+in.right.get(228) * frameCount );
//  
point( wvStart+buf+in.right.get(229) * frameCount, cY+in.left.get(229) * frameCount);
//  
point( wvStart+buf+in.left.get(230) * frameCount, cY+in.right.get(230) * frameCount );
//  
point( wvStart+buf+in.right.get(231) * frameCount, cY+in.left.get(231) * frameCount);
//  
point( wvStart+buf+in.left.get(232) * frameCount, cY+in.right.get(232) * frameCount );
//  
point( wvStart+buf+in.right.get(233) * frameCount, cY+in.left.get(233) * frameCount);
//  
point( wvStart+buf+in.left.get(234) * frameCount, cY+in.right.get(234) * frameCount );
//  
point( wvStart+buf+in.right.get(235) * frameCount, cY+in.left.get(235) * frameCount);
//  
point( wvStart+buf+in.left.get(236) * frameCount, cY+in.right.get(236) * frameCount );
//  
point( wvStart+buf+in.right.get(237) * frameCount, cY+in.left.get(237) * frameCount);
//  
point( wvStart+buf+in.left.get(238) * frameCount, cY+in.right.get(238) * frameCount );
//  
point( wvStart+buf+in.right.get(239) * frameCount, cY+in.left.get(239) * frameCount);
//  
point( wvStart+buf+in.left.get(240) * frameCount, cY+in.right.get(240) * frameCount );
//  
point( wvStart+buf+in.right.get(241) * frameCount, cY+in.left.get(241) * frameCount);
//  
point( wvStart+buf+in.left.get(242) * frameCount, cY+in.right.get(242) * frameCount );
//  
point( wvStart+buf+in.right.get(243) * frameCount, cY+in.left.get(243) * frameCount);
//  
point( wvStart+buf+in.left.get(244) * frameCount, cY+in.right.get(244) * frameCount );
//  
point( wvStart+buf+in.right.get(245) * frameCount, cY+in.left.get(245) * frameCount);
//  
point( wvStart+buf+in.left.get(246) * frameCount, cY+in.right.get(246) * frameCount );
//  
point( wvStart+buf+in.right.get(247) * frameCount, cY+in.left.get(247) * frameCount);
//  
point( wvStart+buf+in.left.get(248) * frameCount, cY+in.right.get(248) * frameCount );
//  
point( wvStart+buf+in.right.get(249) * frameCount, cY+in.left.get(249) * frameCount);
//  
point( wvStart+buf+in.left.get(250) * frameCount, cY+in.right.get(250) * frameCount );
//  
point( wvStart+buf+in.right.get(251) * frameCount, cY+in.left.get(251) * frameCount);
//  
point( wvStart+buf+in.left.get(252) * frameCount, cY+in.right.get(252) * frameCount );
//  
point( wvStart+buf+in.right.get(253) * frameCount, cY+in.left.get(253) * frameCount);
//  
point( wvStart+buf+in.left.get(254) * frameCount, cY+in.right.get(254) * frameCount );
//  
point( wvStart+buf+in.right.get(255) * frameCount, cY+in.left.get(255) * frameCount);
//  
point( wvStart+buf+in.left.get(256) * frameCount, cY+in.right.get(256) * frameCount );
//  
point( wvStart+buf+in.right.get(257) * frameCount, cY+in.left.get(257) * frameCount);
//  
point( wvStart+buf+in.left.get(258) * frameCount, cY+in.right.get(258) * frameCount );
//  
point( wvStart+buf+in.right.get(259) * frameCount, cY+in.left.get(259) * frameCount);
//  
point( wvStart+buf+in.left.get(260) * frameCount, cY+in.right.get(260) * frameCount );
//  
point( wvStart+buf+in.right.get(261) * frameCount, cY+in.left.get(261) * frameCount);
//  
point( wvStart+buf+in.left.get(262) * frameCount, cY+in.right.get(262) * frameCount );
//  
point( wvStart+buf+in.right.get(263) * frameCount, cY+in.left.get(263) * frameCount);
//  
point( wvStart+buf+in.left.get(264) * frameCount, cY+in.right.get(264) * frameCount );
//  
point( wvStart+buf+in.right.get(265) * frameCount, cY+in.left.get(265) * frameCount);
//  
point( wvStart+buf+in.left.get(266) * frameCount, cY+in.right.get(266) * frameCount );
//  
point( wvStart+buf+in.right.get(267) * frameCount, cY+in.left.get(267) * frameCount);
//  
point( wvStart+buf+in.left.get(268) * frameCount, cY+in.right.get(268) * frameCount );
//  
point( wvStart+buf+in.right.get(269) * frameCount, cY+in.left.get(269) * frameCount);
//  
point( wvStart+buf+in.left.get(270) * frameCount, cY+in.right.get(270) * frameCount );
//  
point( wvStart+buf+in.right.get(271) * frameCount, cY+in.left.get(271) * frameCount);
//  
point( wvStart+buf+in.left.get(272) * frameCount, cY+in.right.get(272) * frameCount );
//  
point( wvStart+buf+in.right.get(273) * frameCount, cY+in.left.get(273) * frameCount);
//  
point( wvStart+buf+in.left.get(274) * frameCount, cY+in.right.get(274) * frameCount );
//  
point( wvStart+buf+in.right.get(275) * frameCount, cY+in.left.get(275) * frameCount);
//  
point( wvStart+buf+in.left.get(276) * frameCount, cY+in.right.get(276) * frameCount );
//  
point( wvStart+buf+in.right.get(277) * frameCount, cY+in.left.get(277) * frameCount);
//  
point( wvStart+buf+in.left.get(278) * frameCount, cY+in.right.get(278) * frameCount );
//  
point( wvStart+buf+in.right.get(279) * frameCount, cY+in.left.get(279) * frameCount);
//  
point( wvStart+buf+in.left.get(280) * frameCount, cY+in.right.get(280) * frameCount );
//  
point( wvStart+buf+in.right.get(281) * frameCount, cY+in.left.get(281) * frameCount);
//  
point( wvStart+buf+in.left.get(282) * frameCount, cY+in.right.get(282) * frameCount );
//  
point( wvStart+buf+in.right.get(283) * frameCount, cY+in.left.get(283) * frameCount);
//  
point( wvStart+buf+in.left.get(284) * frameCount, cY+in.right.get(284) * frameCount );
//  
point( wvStart+buf+in.right.get(285) * frameCount, cY+in.left.get(285) * frameCount);
//  
point( wvStart+buf+in.left.get(286) * frameCount, cY+in.right.get(286) * frameCount );
//  
point( wvStart+buf+in.right.get(287) * frameCount, cY+in.left.get(287) * frameCount);
//  
point( wvStart+buf+in.left.get(288) * frameCount, cY+in.right.get(288) * frameCount );
//  
point( wvStart+buf+in.right.get(289) * frameCount, cY+in.left.get(289) * frameCount);
//  
point( wvStart+buf+in.left.get(290) * frameCount, cY+in.right.get(290) * frameCount );
//  
point( wvStart+buf+in.right.get(291) * frameCount, cY+in.left.get(291) * frameCount);
//  
point( wvStart+buf+in.left.get(292) * frameCount, cY+in.right.get(292) * frameCount );
//  
point( wvStart+buf+in.right.get(293) * frameCount, cY+in.left.get(293) * frameCount);
//  
point( wvStart+buf+in.left.get(294) * frameCount, cY+in.right.get(294) * frameCount );
//  
point( wvStart+buf+in.right.get(295) * frameCount, cY+in.left.get(295) * frameCount);
//  
point( wvStart+buf+in.left.get(296) * frameCount, cY+in.right.get(296) * frameCount );
//  
point( wvStart+buf+in.right.get(297) * frameCount, cY+in.left.get(297) * frameCount);
//  
point( wvStart+buf+in.left.get(298) * frameCount, cY+in.right.get(298) * frameCount );
//  
point( wvStart+buf+in.right.get(299) * frameCount, cY+in.left.get(299) * frameCount);
//  
point( wvStart+buf+in.left.get(300) * frameCount, cY+in.right.get(300) * frameCount );
//  
point( wvStart+buf+in.right.get(301) * frameCount, cY+in.left.get(301) * frameCount);
//  
point( wvStart+buf+in.left.get(302) * frameCount, cY+in.right.get(302) * frameCount );
//  
point( wvStart+buf+in.right.get(303) * frameCount, cY+in.left.get(303) * frameCount);
//  
point( wvStart+buf+in.left.get(304) * frameCount, cY+in.right.get(304) * frameCount );
//  
point( wvStart+buf+in.right.get(305) * frameCount, cY+in.left.get(305) * frameCount);
//  
point( wvStart+buf+in.left.get(306) * frameCount, cY+in.right.get(306) * frameCount );
//  
point( wvStart+buf+in.right.get(307) * frameCount, cY+in.left.get(307) * frameCount);
//  
point( wvStart+buf+in.left.get(308) * frameCount, cY+in.right.get(308) * frameCount );
//  
point( wvStart+buf+in.right.get(309) * frameCount, cY+in.left.get(309) * frameCount);
//  
point( wvStart+buf+in.left.get(310) * frameCount, cY+in.right.get(310) * frameCount );
//  
point( wvStart+buf+in.right.get(311) * frameCount, cY+in.left.get(311) * frameCount);
//  
point( wvStart+buf+in.left.get(312) * frameCount, cY+in.right.get(312) * frameCount );
//  
point( wvStart+buf+in.right.get(313) * frameCount, cY+in.left.get(313) * frameCount);
//  
point( wvStart+buf+in.left.get(314) * frameCount, cY+in.right.get(314) * frameCount );
//  
point( wvStart+buf+in.right.get(315) * frameCount, cY+in.left.get(315) * frameCount);
//  
point( wvStart+buf+in.left.get(316) * frameCount, cY+in.right.get(316) * frameCount );
//  
point( wvStart+buf+in.right.get(317) * frameCount, cY+in.left.get(317) * frameCount);
//  
point( wvStart+buf+in.left.get(318) * frameCount, cY+in.right.get(318) * frameCount );
//  
point( wvStart+buf+in.right.get(319) * frameCount, cY+in.left.get(319) * frameCount);
//  
point( wvStart+buf+in.left.get(320) * frameCount, cY+in.right.get(320) * frameCount );
//  
point( wvStart+buf+in.right.get(321) * frameCount, cY+in.left.get(321) * frameCount);
//  
point( wvStart+buf+in.left.get(322) * frameCount, cY+in.right.get(322) * frameCount );
//  
point( wvStart+buf+in.right.get(323) * frameCount, cY+in.left.get(323) * frameCount);
//  
point( wvStart+buf+in.left.get(324) * frameCount, cY+in.right.get(324) * frameCount );
//  
point( wvStart+buf+in.right.get(325) * frameCount, cY+in.left.get(325) * frameCount);
//  
point( wvStart+buf+in.left.get(326) * frameCount, cY+in.right.get(326) * frameCount );
//  
point( wvStart+buf+in.right.get(327) * frameCount, cY+in.left.get(327) * frameCount);
//  
point( wvStart+buf+in.left.get(328) * frameCount, cY+in.right.get(328) * frameCount );
//  
point( wvStart+buf+in.right.get(329) * frameCount, cY+in.left.get(329) * frameCount);
//  
point( wvStart+buf+in.left.get(330) * frameCount, cY+in.right.get(330) * frameCount );
//  
point( wvStart+buf+in.right.get(331) * frameCount, cY+in.left.get(331) * frameCount);
//  
point( wvStart+buf+in.left.get(332) * frameCount, cY+in.right.get(332) * frameCount );
//  
point( wvStart+buf+in.right.get(333) * frameCount, cY+in.left.get(333) * frameCount);
//  
point( wvStart+buf+in.left.get(334) * frameCount, cY+in.right.get(334) * frameCount );
//  
point( wvStart+buf+in.right.get(335) * frameCount, cY+in.left.get(335) * frameCount);
//  
point( wvStart+buf+in.left.get(336) * frameCount, cY+in.right.get(336) * frameCount );
//  
point( wvStart+buf+in.right.get(337) * frameCount, cY+in.left.get(337) * frameCount);
//  
point( wvStart+buf+in.left.get(338) * frameCount, cY+in.right.get(338) * frameCount );
//  
point( wvStart+buf+in.right.get(339) * frameCount, cY+in.left.get(339) * frameCount);
//  
point( wvStart+buf+in.left.get(340) * frameCount, cY+in.right.get(340) * frameCount );
//  
point( wvStart+buf+in.right.get(341) * frameCount, cY+in.left.get(341) * frameCount);
//  
point( wvStart+buf+in.left.get(342) * frameCount, cY+in.right.get(342) * frameCount );
//  
point( wvStart+buf+in.right.get(343) * frameCount, cY+in.left.get(343) * frameCount);
//  
point( wvStart+buf+in.left.get(344) * frameCount, cY+in.right.get(344) * frameCount );
//  
point( wvStart+buf+in.right.get(345) * frameCount, cY+in.left.get(345) * frameCount);
//  
point( wvStart+buf+in.left.get(346) * frameCount, cY+in.right.get(346) * frameCount );
//  
point( wvStart+buf+in.right.get(347) * frameCount, cY+in.left.get(347) * frameCount);
//  
point( wvStart+buf+in.left.get(348) * frameCount, cY+in.right.get(348) * frameCount );
//  
point( wvStart+buf+in.right.get(349) * frameCount, cY+in.left.get(349) * frameCount);
//  
point( wvStart+buf+in.left.get(350) * frameCount, cY+in.right.get(350) * frameCount );
//  
point( wvStart+buf+in.right.get(351) * frameCount, cY+in.left.get(351) * frameCount);
//  
point( wvStart+buf+in.left.get(352) * frameCount, cY+in.right.get(352) * frameCount );
//  
point( wvStart+buf+in.right.get(353) * frameCount, cY+in.left.get(353) * frameCount);
//  
point( wvStart+buf+in.left.get(354) * frameCount, cY+in.right.get(354) * frameCount );
//  
point( wvStart+buf+in.right.get(355) * frameCount, cY+in.left.get(355) * frameCount);
//  
point( wvStart+buf+in.left.get(356) * frameCount, cY+in.right.get(356) * frameCount );
//  
point( wvStart+buf+in.right.get(357) * frameCount, cY+in.left.get(357) * frameCount);
//  
point( wvStart+buf+in.left.get(358) * frameCount, cY+in.right.get(358) * frameCount );
//  
point( wvStart+buf+in.right.get(359) * frameCount, cY+in.left.get(359) * frameCount);
//  
point( wvStart+buf+in.left.get(360) * frameCount, cY+in.right.get(360) * frameCount );
//  
point( wvStart+buf+in.right.get(361) * frameCount, cY+in.left.get(361) * frameCount);
//  
point( wvStart+buf+in.left.get(362) * frameCount, cY+in.right.get(362) * frameCount );
//  
point( wvStart+buf+in.right.get(363) * frameCount, cY+in.left.get(363) * frameCount);
//  
point( wvStart+buf+in.left.get(364) * frameCount, cY+in.right.get(364) * frameCount );
//  
point( wvStart+buf+in.right.get(365) * frameCount, cY+in.left.get(365) * frameCount);
//  
point( wvStart+buf+in.left.get(366) * frameCount, cY+in.right.get(366) * frameCount );
//  
point( wvStart+buf+in.right.get(367) * frameCount, cY+in.left.get(367) * frameCount);
//  
point( wvStart+buf+in.left.get(368) * frameCount, cY+in.right.get(368) * frameCount );
//  
point( wvStart+buf+in.right.get(369) * frameCount, cY+in.left.get(369) * frameCount);
//  
point( wvStart+buf+in.left.get(370) * frameCount, cY+in.right.get(370) * frameCount );
//  
point( wvStart+buf+in.right.get(371) * frameCount, cY+in.left.get(371) * frameCount);
//  
point( wvStart+buf+in.left.get(372) * frameCount, cY+in.right.get(372) * frameCount );
//  
point( wvStart+buf+in.right.get(373) * frameCount, cY+in.left.get(373) * frameCount);
//  
point( wvStart+buf+in.left.get(374) * frameCount, cY+in.right.get(374) * frameCount );
//  
point( wvStart+buf+in.right.get(375) * frameCount, cY+in.left.get(375) * frameCount);
//  
point( wvStart+buf+in.left.get(376) * frameCount, cY+in.right.get(376) * frameCount );
//  
point( wvStart+buf+in.right.get(377) * frameCount, cY+in.left.get(377) * frameCount);
//  
point( wvStart+buf+in.left.get(378) * frameCount, cY+in.right.get(378) * frameCount );
//  
point( wvStart+buf+in.right.get(379) * frameCount, cY+in.left.get(379) * frameCount);
//  
point( wvStart+buf+in.left.get(380) * frameCount, cY+in.right.get(380) * frameCount );
//  
point( wvStart+buf+in.right.get(381) * frameCount, cY+in.left.get(381) * frameCount);
//  
point( wvStart+buf+in.left.get(382) * frameCount, cY+in.right.get(382) * frameCount );
//  
point( wvStart+buf+in.right.get(383) * frameCount, cY+in.left.get(383) * frameCount);
//  
point( wvStart+buf+in.left.get(384) * frameCount, cY+in.right.get(384) * frameCount );
//  
point( wvStart+buf+in.right.get(385) * frameCount, cY+in.left.get(385) * frameCount);
//  
point( wvStart+buf+in.left.get(386) * frameCount, cY+in.right.get(386) * frameCount );
//  
point( wvStart+buf+in.right.get(387) * frameCount, cY+in.left.get(387) * frameCount);
//  
point( wvStart+buf+in.left.get(388) * frameCount, cY+in.right.get(388) * frameCount );
//  
point( wvStart+buf+in.right.get(389) * frameCount, cY+in.left.get(389) * frameCount);
//  
point( wvStart+buf+in.left.get(390) * frameCount, cY+in.right.get(390) * frameCount );
//  
point( wvStart+buf+in.right.get(391) * frameCount, cY+in.left.get(391) * frameCount);
//  
point( wvStart+buf+in.left.get(392) * frameCount, cY+in.right.get(392) * frameCount );
//  
point( wvStart+buf+in.right.get(393) * frameCount, cY+in.left.get(393) * frameCount);
//  
point( wvStart+buf+in.left.get(394) * frameCount, cY+in.right.get(394) * frameCount );
//  
point( wvStart+buf+in.right.get(395) * frameCount, cY+in.left.get(395) * frameCount);
//  
point( wvStart+buf+in.left.get(396) * frameCount, cY+in.right.get(396) * frameCount );
//  
point( wvStart+buf+in.right.get(397) * frameCount, cY+in.left.get(397) * frameCount);
//  
point( wvStart+buf+in.left.get(398) * frameCount, cY+in.right.get(398) * frameCount );
//  
point( wvStart+buf+in.right.get(399) * frameCount, cY+in.left.get(399) * frameCount);
//  
point( wvStart+buf+in.left.get(400) * frameCount, cY+in.right.get(400) * frameCount );
//  
point( wvStart+buf+in.right.get(401) * frameCount, cY+in.left.get(401) * frameCount);
//  
point( wvStart+buf+in.left.get(402) * frameCount, cY+in.right.get(402) * frameCount );
//  
point( wvStart+buf+in.right.get(403) * frameCount, cY+in.left.get(403) * frameCount);
//  
point( wvStart+buf+in.left.get(404) * frameCount, cY+in.right.get(404) * frameCount );
//  
point( wvStart+buf+in.right.get(405) * frameCount, cY+in.left.get(405) * frameCount);
//  
point( wvStart+buf+in.left.get(406) * frameCount, cY+in.right.get(406) * frameCount );
//  
point( wvStart+buf+in.right.get(407) * frameCount, cY+in.left.get(407) * frameCount);
//  
point( wvStart+buf+in.left.get(408) * frameCount, cY+in.right.get(408) * frameCount );
//  
point( wvStart+buf+in.right.get(409) * frameCount, cY+in.left.get(409) * frameCount);
//  
point( wvStart+buf+in.left.get(410) * frameCount, cY+in.right.get(410) * frameCount );
//  
point( wvStart+buf+in.right.get(411) * frameCount, cY+in.left.get(411) * frameCount);
//  
point( wvStart+buf+in.left.get(412) * frameCount, cY+in.right.get(412) * frameCount );
//  
point( wvStart+buf+in.right.get(413) * frameCount, cY+in.left.get(413) * frameCount);
//  
point( wvStart+buf+in.left.get(414) * frameCount, cY+in.right.get(414) * frameCount );
//  
point( wvStart+buf+in.right.get(415) * frameCount, cY+in.left.get(415) * frameCount);
//  
point( wvStart+buf+in.left.get(416) * frameCount, cY+in.right.get(416) * frameCount );
//  
point( wvStart+buf+in.right.get(417) * frameCount, cY+in.left.get(417) * frameCount);
//  
point( wvStart+buf+in.left.get(418) * frameCount, cY+in.right.get(418) * frameCount );
//  
point( wvStart+buf+in.right.get(419) * frameCount, cY+in.left.get(419) * frameCount);
//  
point( wvStart+buf+in.left.get(420) * frameCount, cY+in.right.get(420) * frameCount );
//  
point( wvStart+buf+in.right.get(421) * frameCount, cY+in.left.get(421) * frameCount);
//  
point( wvStart+buf+in.left.get(422) * frameCount, cY+in.right.get(422) * frameCount );
//  
point( wvStart+buf+in.right.get(423) * frameCount, cY+in.left.get(423) * frameCount);
//  
point( wvStart+buf+in.left.get(424) * frameCount, cY+in.right.get(424) * frameCount );
//  
point( wvStart+buf+in.right.get(425) * frameCount, cY+in.left.get(425) * frameCount);
//  
point( wvStart+buf+in.left.get(426) * frameCount, cY+in.right.get(426) * frameCount );
//  
point( wvStart+buf+in.right.get(427) * frameCount, cY+in.left.get(427) * frameCount);
//  
point( wvStart+buf+in.left.get(428) * frameCount, cY+in.right.get(428) * frameCount );
//  
point( wvStart+buf+in.right.get(429) * frameCount, cY+in.left.get(429) * frameCount);
//  
point( wvStart+buf+in.left.get(430) * frameCount, cY+in.right.get(430) * frameCount );
//  
point( wvStart+buf+in.right.get(431) * frameCount, cY+in.left.get(431) * frameCount);
//  
point( wvStart+buf+in.left.get(432) * frameCount, cY+in.right.get(432) * frameCount );
//  
point( wvStart+buf+in.right.get(433) * frameCount, cY+in.left.get(433) * frameCount);
//  
point( wvStart+buf+in.left.get(434) * frameCount, cY+in.right.get(434) * frameCount );
//  
point( wvStart+buf+in.right.get(435) * frameCount, cY+in.left.get(435) * frameCount);
//  
point( wvStart+buf+in.left.get(436) * frameCount, cY+in.right.get(436) * frameCount );
//  
point( wvStart+buf+in.right.get(437) * frameCount, cY+in.left.get(437) * frameCount);
//  
point( wvStart+buf+in.left.get(438) * frameCount, cY+in.right.get(438) * frameCount );
//  
point( wvStart+buf+in.right.get(439) * frameCount, cY+in.left.get(439) * frameCount);
//  
point( wvStart+buf+in.left.get(440) * frameCount, cY+in.right.get(440) * frameCount );
//  
point( wvStart+buf+in.right.get(441) * frameCount, cY+in.left.get(441) * frameCount);
//  
point( wvStart+buf+in.left.get(442) * frameCount, cY+in.right.get(442) * frameCount );
//  
point( wvStart+buf+in.right.get(443) * frameCount, cY+in.left.get(443) * frameCount);
//  
point( wvStart+buf+in.left.get(444) * frameCount, cY+in.right.get(444) * frameCount );
//  
point( wvStart+buf+in.right.get(445) * frameCount, cY+in.left.get(445) * frameCount);
//  
point( wvStart+buf+in.left.get(446) * frameCount, cY+in.right.get(446) * frameCount );
//  
point( wvStart+buf+in.right.get(447) * frameCount, cY+in.left.get(447) * frameCount);
//  
point( wvStart+buf+in.left.get(448) * frameCount, cY+in.right.get(448) * frameCount );
//  
point( wvStart+buf+in.right.get(449) * frameCount, cY+in.left.get(449) * frameCount);
//  
point( wvStart+buf+in.left.get(450) * frameCount, cY+in.right.get(450) * frameCount );
//  
point( wvStart+buf+in.right.get(451) * frameCount, cY+in.left.get(451) * frameCount);
//  
point( wvStart+buf+in.left.get(452) * frameCount, cY+in.right.get(452) * frameCount );
//  
point( wvStart+buf+in.right.get(453) * frameCount, cY+in.left.get(453) * frameCount);
//  
point( wvStart+buf+in.left.get(454) * frameCount, cY+in.right.get(454) * frameCount );
//  
point( wvStart+buf+in.right.get(455) * frameCount, cY+in.left.get(455) * frameCount);
//  
point( wvStart+buf+in.left.get(456) * frameCount, cY+in.right.get(456) * frameCount );
//  
point( wvStart+buf+in.right.get(457) * frameCount, cY+in.left.get(457) * frameCount);
//  
point( wvStart+buf+in.left.get(458) * frameCount, cY+in.right.get(458) * frameCount );
//  
point( wvStart+buf+in.right.get(459) * frameCount, cY+in.left.get(459) * frameCount);
//  
point( wvStart+buf+in.left.get(460) * frameCount, cY+in.right.get(460) * frameCount );
//  
point( wvStart+buf+in.right.get(461) * frameCount, cY+in.left.get(461) * frameCount);
//  
point( wvStart+buf+in.left.get(462) * frameCount, cY+in.right.get(462) * frameCount );
//  
point( wvStart+buf+in.right.get(463) * frameCount, cY+in.left.get(463) * frameCount);
//  
point( wvStart+buf+in.left.get(464) * frameCount, cY+in.right.get(464) * frameCount );
//  
point( wvStart+buf+in.right.get(465) * frameCount, cY+in.left.get(465) * frameCount);
//  
point( wvStart+buf+in.left.get(466) * frameCount, cY+in.right.get(466) * frameCount );
//  
point( wvStart+buf+in.right.get(467) * frameCount, cY+in.left.get(467) * frameCount);
//  
point( wvStart+buf+in.left.get(468) * frameCount, cY+in.right.get(468) * frameCount );
//  
point( wvStart+buf+in.right.get(469) * frameCount, cY+in.left.get(469) * frameCount);
//  
point( wvStart+buf+in.left.get(470) * frameCount, cY+in.right.get(470) * frameCount );
//  
point( wvStart+buf+in.right.get(471) * frameCount, cY+in.left.get(471) * frameCount);
//  
point( wvStart+buf+in.left.get(472) * frameCount, cY+in.right.get(472) * frameCount );
//  
point( wvStart+buf+in.right.get(473) * frameCount, cY+in.left.get(473) * frameCount);
//  
point( wvStart+buf+in.left.get(474) * frameCount, cY+in.right.get(474) * frameCount );
//  
point( wvStart+buf+in.right.get(475) * frameCount, cY+in.left.get(475) * frameCount);
//  
point( wvStart+buf+in.left.get(476) * frameCount, cY+in.right.get(476) * frameCount );
//  
point( wvStart+buf+in.right.get(477) * frameCount, cY+in.left.get(477) * frameCount);
//  
point( wvStart+buf+in.left.get(478) * frameCount, cY+in.right.get(478) * frameCount );
//  
point( wvStart+buf+in.right.get(479) * frameCount, cY+in.left.get(479) * frameCount);
//  
point( wvStart+buf+in.left.get(480) * frameCount, cY+in.right.get(480) * frameCount );
//  
point( wvStart+buf+in.right.get(481) * frameCount, cY+in.left.get(481) * frameCount);
//  
point( wvStart+buf+in.left.get(482) * frameCount, cY+in.right.get(482) * frameCount );
//  
point( wvStart+buf+in.right.get(483) * frameCount, cY+in.left.get(483) * frameCount);
//  
point( wvStart+buf+in.left.get(484) * frameCount, cY+in.right.get(484) * frameCount );
//  
point( wvStart+buf+in.right.get(485) * frameCount, cY+in.left.get(485) * frameCount);
//  
point( wvStart+buf+in.left.get(486) * frameCount, cY+in.right.get(486) * frameCount );
//  
point( wvStart+buf+in.right.get(487) * frameCount, cY+in.left.get(487) * frameCount);
//  
point( wvStart+buf+in.left.get(488) * frameCount, cY+in.right.get(488) * frameCount );
//  
point( wvStart+buf+in.right.get(489) * frameCount, cY+in.left.get(489) * frameCount);
//  
point( wvStart+buf+in.left.get(490) * frameCount, cY+in.right.get(490) * frameCount );
//  
point( wvStart+buf+in.right.get(491) * frameCount, cY+in.left.get(491) * frameCount);
//  
point( wvStart+buf+in.left.get(492) * frameCount, cY+in.right.get(492) * frameCount );
//  
point( wvStart+buf+in.right.get(493) * frameCount, cY+in.left.get(493) * frameCount);
//  
point( wvStart+buf+in.left.get(494) * frameCount, cY+in.right.get(494) * frameCount );
//  
point( wvStart+buf+in.right.get(495) * frameCount, cY+in.left.get(495) * frameCount);
//  
point( wvStart+buf+in.left.get(496) * frameCount, cY+in.right.get(496) * frameCount );
//  
point( wvStart+buf+in.right.get(497) * frameCount, cY+in.left.get(497) * frameCount);
//  
point( wvStart+buf+in.left.get(498) * frameCount, cY+in.right.get(498) * frameCount );
//  
point( wvStart+buf+in.right.get(499) * frameCount, cY+in.left.get(499) * frameCount);
//  
point( wvStart+buf+in.left.get(500) * frameCount, cY+in.right.get(500) * frameCount );
//  
point( wvStart+buf+in.right.get(501) * frameCount, cY+in.left.get(501) * frameCount);
//  
point( wvStart+buf+in.left.get(502) * frameCount, cY+in.right.get(502) * frameCount );
//  
point( wvStart+buf+in.right.get(503) * frameCount, cY+in.left.get(503) * frameCount);
//  
point( wvStart+buf+in.left.get(504) * frameCount, cY+in.right.get(504) * frameCount );
//  
point( wvStart+buf+in.right.get(505) * frameCount, cY+in.left.get(505) * frameCount);
//  
point( wvStart+buf+in.left.get(506) * frameCount, cY+in.right.get(506) * frameCount );
//  
point( wvStart+buf+in.right.get(507) * frameCount, cY+in.left.get(507) * frameCount);
//  
point( wvStart+buf+in.left.get(508) * frameCount, cY+in.right.get(508) * frameCount );
//  
point( wvStart+buf+in.right.get(509) * frameCount, cY+in.left.get(509) * frameCount);
//  
point( wvStart+buf+in.left.get(510) * frameCount, cY+in.right.get(510) * frameCount );
//  
point( wvStart+buf+in.right.get(511) * frameCount, cY+in.left.get(511) * frameCount);
//  
point( wvStart+buf+in.left.get(512) * frameCount, cY+in.right.get(512) * frameCount );
//  
point( wvStart+buf+in.right.get(513) * frameCount, cY+in.left.get(513) * frameCount);
//  
point( wvStart+buf+in.left.get(514) * frameCount, cY+in.right.get(514) * frameCount );
//  
point( wvStart+buf+in.right.get(515) * frameCount, cY+in.left.get(515) * frameCount);
//  
point( wvStart+buf+in.left.get(516) * frameCount, cY+in.right.get(516) * frameCount );
//  
point( wvStart+buf+in.right.get(517) * frameCount, cY+in.left.get(517) * frameCount);
//  
point( wvStart+buf+in.left.get(518) * frameCount, cY+in.right.get(518) * frameCount );
//  
point( wvStart+buf+in.right.get(519) * frameCount, cY+in.left.get(519) * frameCount);
//  
point( wvStart+buf+in.left.get(520) * frameCount, cY+in.right.get(520) * frameCount );
//  
point( wvStart+buf+in.right.get(521) * frameCount, cY+in.left.get(521) * frameCount);
//  
point( wvStart+buf+in.left.get(522) * frameCount, cY+in.right.get(522) * frameCount );
//  
point( wvStart+buf+in.right.get(523) * frameCount, cY+in.left.get(523) * frameCount);
//  
point( wvStart+buf+in.left.get(524) * frameCount, cY+in.right.get(524) * frameCount );
//  
point( wvStart+buf+in.right.get(525) * frameCount, cY+in.left.get(525) * frameCount);
//  
point( wvStart+buf+in.left.get(526) * frameCount, cY+in.right.get(526) * frameCount );
//  
point( wvStart+buf+in.right.get(527) * frameCount, cY+in.left.get(527) * frameCount);
//  
point( wvStart+buf+in.left.get(528) * frameCount, cY+in.right.get(528) * frameCount );
//  
point( wvStart+buf+in.right.get(529) * frameCount, cY+in.left.get(529) * frameCount);
//  
point( wvStart+buf+in.left.get(530) * frameCount, cY+in.right.get(530) * frameCount );
//  
point( wvStart+buf+in.right.get(531) * frameCount, cY+in.left.get(531) * frameCount);
//  
point( wvStart+buf+in.left.get(532) * frameCount, cY+in.right.get(532) * frameCount );
//  
point( wvStart+buf+in.right.get(533) * frameCount, cY+in.left.get(533) * frameCount);
//  
point( wvStart+buf+in.left.get(534) * frameCount, cY+in.right.get(534) * frameCount );
//  
point( wvStart+buf+in.right.get(535) * frameCount, cY+in.left.get(535) * frameCount);
//  
point( wvStart+buf+in.left.get(536) * frameCount, cY+in.right.get(536) * frameCount );
//  
point( wvStart+buf+in.right.get(537) * frameCount, cY+in.left.get(537) * frameCount);
//  
point( wvStart+buf+in.left.get(538) * frameCount, cY+in.right.get(538) * frameCount );
//  
point( wvStart+buf+in.right.get(539) * frameCount, cY+in.left.get(539) * frameCount);
//  
point( wvStart+buf+in.left.get(540) * frameCount, cY+in.right.get(540) * frameCount );
//  
point( wvStart+buf+in.right.get(541) * frameCount, cY+in.left.get(541) * frameCount);
//  
point( wvStart+buf+in.left.get(542) * frameCount, cY+in.right.get(542) * frameCount );
//  
point( wvStart+buf+in.right.get(543) * frameCount, cY+in.left.get(543) * frameCount);
//  
point( wvStart+buf+in.left.get(544) * frameCount, cY+in.right.get(544) * frameCount );
//  
point( wvStart+buf+in.right.get(545) * frameCount, cY+in.left.get(545) * frameCount);
//  
point( wvStart+buf+in.left.get(546) * frameCount, cY+in.right.get(546) * frameCount );
//  
point( wvStart+buf+in.right.get(547) * frameCount, cY+in.left.get(547) * frameCount);
//  
point( wvStart+buf+in.left.get(548) * frameCount, cY+in.right.get(548) * frameCount );
//  
point( wvStart+buf+in.right.get(549) * frameCount, cY+in.left.get(549) * frameCount);
//  
point( wvStart+buf+in.left.get(550) * frameCount, cY+in.right.get(550) * frameCount );
//  
point( wvStart+buf+in.right.get(551) * frameCount, cY+in.left.get(551) * frameCount);
//  
point( wvStart+buf+in.left.get(552) * frameCount, cY+in.right.get(552) * frameCount );
//  
point( wvStart+buf+in.right.get(553) * frameCount, cY+in.left.get(553) * frameCount);
//  
point( wvStart+buf+in.left.get(554) * frameCount, cY+in.right.get(554) * frameCount );
//  
point( wvStart+buf+in.right.get(555) * frameCount, cY+in.left.get(555) * frameCount);
//  
point( wvStart+buf+in.left.get(556) * frameCount, cY+in.right.get(556) * frameCount );
//  
point( wvStart+buf+in.right.get(557) * frameCount, cY+in.left.get(557) * frameCount);
//  
point( wvStart+buf+in.left.get(558) * frameCount, cY+in.right.get(558) * frameCount );
//  
point( wvStart+buf+in.right.get(559) * frameCount, cY+in.left.get(559) * frameCount);
//  
point( wvStart+buf+in.left.get(560) * frameCount, cY+in.right.get(560) * frameCount );
//  
point( wvStart+buf+in.right.get(561) * frameCount, cY+in.left.get(561) * frameCount);
//  
point( wvStart+buf+in.left.get(562) * frameCount, cY+in.right.get(562) * frameCount );
//  
point( wvStart+buf+in.right.get(563) * frameCount, cY+in.left.get(563) * frameCount);
//  
point( wvStart+buf+in.left.get(564) * frameCount, cY+in.right.get(564) * frameCount );
//  
point( wvStart+buf+in.right.get(565) * frameCount, cY+in.left.get(565) * frameCount);
//  
point( wvStart+buf+in.left.get(566) * frameCount, cY+in.right.get(566) * frameCount );
//  
point( wvStart+buf+in.right.get(567) * frameCount, cY+in.left.get(567) * frameCount);
//  
point( wvStart+buf+in.left.get(568) * frameCount, cY+in.right.get(568) * frameCount );
//  
point( wvStart+buf+in.right.get(569) * frameCount, cY+in.left.get(569) * frameCount);
//  
point( wvStart+buf+in.left.get(570) * frameCount, cY+in.right.get(570) * frameCount );
//  
point( wvStart+buf+in.right.get(571) * frameCount, cY+in.left.get(571) * frameCount);
//  
point( wvStart+buf+in.left.get(572) * frameCount, cY+in.right.get(572) * frameCount );
//  
point( wvStart+buf+in.right.get(573) * frameCount, cY+in.left.get(573) * frameCount);
//  
point( wvStart+buf+in.left.get(574) * frameCount, cY+in.right.get(574) * frameCount );
//  
point( wvStart+buf+in.right.get(575) * frameCount, cY+in.left.get(575) * frameCount);
//  
point( wvStart+buf+in.left.get(576) * frameCount, cY+in.right.get(576) * frameCount );
//  
point( wvStart+buf+in.right.get(577) * frameCount, cY+in.left.get(577) * frameCount);
//  
point( wvStart+buf+in.left.get(578) * frameCount, cY+in.right.get(578) * frameCount );
//  
point( wvStart+buf+in.right.get(579) * frameCount, cY+in.left.get(579) * frameCount);
//  
point( wvStart+buf+in.left.get(580) * frameCount, cY+in.right.get(580) * frameCount );
//  
point( wvStart+buf+in.right.get(581) * frameCount, cY+in.left.get(581) * frameCount);
//  
point( wvStart+buf+in.left.get(582) * frameCount, cY+in.right.get(582) * frameCount );
//  
point( wvStart+buf+in.right.get(583) * frameCount, cY+in.left.get(583) * frameCount);
//  
point( wvStart+buf+in.left.get(584) * frameCount, cY+in.right.get(584) * frameCount );
//  
point( wvStart+buf+in.right.get(585) * frameCount, cY+in.left.get(585) * frameCount);
//  
point( wvStart+buf+in.left.get(586) * frameCount, cY+in.right.get(586) * frameCount );
//  
point( wvStart+buf+in.right.get(587) * frameCount, cY+in.left.get(587) * frameCount);
//  
point( wvStart+buf+in.left.get(588) * frameCount, cY+in.right.get(588) * frameCount );
//  
point( wvStart+buf+in.right.get(589) * frameCount, cY+in.left.get(589) * frameCount);
//  
point( wvStart+buf+in.left.get(590) * frameCount, cY+in.right.get(590) * frameCount );
//  
point( wvStart+buf+in.right.get(591) * frameCount, cY+in.left.get(591) * frameCount);
//  
point( wvStart+buf+in.left.get(592) * frameCount, cY+in.right.get(592) * frameCount );
//  
point( wvStart+buf+in.right.get(593) * frameCount, cY+in.left.get(593) * frameCount);
//  
point( wvStart+buf+in.left.get(594) * frameCount, cY+in.right.get(594) * frameCount );
//  
point( wvStart+buf+in.right.get(595) * frameCount, cY+in.left.get(595) * frameCount);
//  
point( wvStart+buf+in.left.get(596) * frameCount, cY+in.right.get(596) * frameCount );
//  
point( wvStart+buf+in.right.get(597) * frameCount, cY+in.left.get(597) * frameCount);
//  
point( wvStart+buf+in.left.get(598) * frameCount, cY+in.right.get(598) * frameCount );
//  
point( wvStart+buf+in.right.get(599) * frameCount, cY+in.left.get(599) * frameCount);
//  
point( wvStart+buf+in.left.get(600) * frameCount, cY+in.right.get(600) * frameCount );
//  
point( wvStart+buf+in.right.get(601) * frameCount, cY+in.left.get(601) * frameCount);
//  
point( wvStart+buf+in.left.get(602) * frameCount, cY+in.right.get(602) * frameCount );
//  
point( wvStart+buf+in.right.get(603) * frameCount, cY+in.left.get(603) * frameCount);
//  
point( wvStart+buf+in.left.get(604) * frameCount, cY+in.right.get(604) * frameCount );
//  
point( wvStart+buf+in.right.get(605) * frameCount, cY+in.left.get(605) * frameCount);
//  
point( wvStart+buf+in.left.get(606) * frameCount, cY+in.right.get(606) * frameCount );
//  
point( wvStart+buf+in.right.get(607) * frameCount, cY+in.left.get(607) * frameCount);
//  
point( wvStart+buf+in.left.get(608) * frameCount, cY+in.right.get(608) * frameCount );
//  
point( wvStart+buf+in.right.get(609) * frameCount, cY+in.left.get(609) * frameCount);
//  
point( wvStart+buf+in.left.get(610) * frameCount, cY+in.right.get(610) * frameCount );
//  
point( wvStart+buf+in.right.get(611) * frameCount, cY+in.left.get(611) * frameCount);
//  
point( wvStart+buf+in.left.get(612) * frameCount, cY+in.right.get(612) * frameCount );
//  
point( wvStart+buf+in.right.get(613) * frameCount, cY+in.left.get(613) * frameCount);
//  
point( wvStart+buf+in.left.get(614) * frameCount, cY+in.right.get(614) * frameCount );
//  
point( wvStart+buf+in.right.get(615) * frameCount, cY+in.left.get(615) * frameCount);
//  
point( wvStart+buf+in.left.get(616) * frameCount, cY+in.right.get(616) * frameCount );
//  
point( wvStart+buf+in.right.get(617) * frameCount, cY+in.left.get(617) * frameCount);
//  
point( wvStart+buf+in.left.get(618) * frameCount, cY+in.right.get(618) * frameCount );
//  
point( wvStart+buf+in.right.get(619) * frameCount, cY+in.left.get(619) * frameCount);
//  
point( wvStart+buf+in.left.get(620) * frameCount, cY+in.right.get(620) * frameCount );
//  
point( wvStart+buf+in.right.get(621) * frameCount, cY+in.left.get(621) * frameCount);
//  
point( wvStart+buf+in.left.get(622) * frameCount, cY+in.right.get(622) * frameCount );
//  
point( wvStart+buf+in.right.get(623) * frameCount, cY+in.left.get(623) * frameCount);
//  
point( wvStart+buf+in.left.get(624) * frameCount, cY+in.right.get(624) * frameCount );
//  
point( wvStart+buf+in.right.get(625) * frameCount, cY+in.left.get(625) * frameCount);
//  
point( wvStart+buf+in.left.get(626) * frameCount, cY+in.right.get(626) * frameCount );
//  
point( wvStart+buf+in.right.get(627) * frameCount, cY+in.left.get(627) * frameCount);
//  
point( wvStart+buf+in.left.get(628) * frameCount, cY+in.right.get(628) * frameCount );
//  
point( wvStart+buf+in.right.get(629) * frameCount, cY+in.left.get(629) * frameCount);
//  
point( wvStart+buf+in.left.get(630) * frameCount, cY+in.right.get(630) * frameCount );
//  
point( wvStart+buf+in.right.get(631) * frameCount, cY+in.left.get(631) * frameCount);
//  
point( wvStart+buf+in.left.get(632) * frameCount, cY+in.right.get(632) * frameCount );
//  
point( wvStart+buf+in.right.get(633) * frameCount, cY+in.left.get(633) * frameCount);
//  
point( wvStart+buf+in.left.get(634) * frameCount, cY+in.right.get(634) * frameCount );
//  
point( wvStart+buf+in.right.get(635) * frameCount, cY+in.left.get(635) * frameCount);
//  
point( wvStart+buf+in.left.get(636) * frameCount, cY+in.right.get(636) * frameCount );
//  
point( wvStart+buf+in.right.get(637) * frameCount, cY+in.left.get(637) * frameCount);
//  
point( wvStart+buf+in.left.get(638) * frameCount, cY+in.right.get(638) * frameCount );
//  
point( wvStart+buf+in.right.get(639) * frameCount, cY+in.left.get(639) * frameCount);
//  
point( wvStart+buf+in.left.get(640) * frameCount, cY+in.right.get(640) * frameCount );
//  
point( wvStart+buf+in.right.get(641) * frameCount, cY+in.left.get(641) * frameCount);
//  
point( wvStart+buf+in.left.get(642) * frameCount, cY+in.right.get(642) * frameCount );
//  
point( wvStart+buf+in.right.get(643) * frameCount, cY+in.left.get(643) * frameCount);
//  
point( wvStart+buf+in.left.get(644) * frameCount, cY+in.right.get(644) * frameCount );
//  
point( wvStart+buf+in.right.get(645) * frameCount, cY+in.left.get(645) * frameCount);
//  
point( wvStart+buf+in.left.get(646) * frameCount, cY+in.right.get(646) * frameCount );
//  
point( wvStart+buf+in.right.get(647) * frameCount, cY+in.left.get(647) * frameCount);
//  
point( wvStart+buf+in.left.get(648) * frameCount, cY+in.right.get(648) * frameCount );
//  
point( wvStart+buf+in.right.get(649) * frameCount, cY+in.left.get(649) * frameCount);
//  
point( wvStart+buf+in.left.get(650) * frameCount, cY+in.right.get(650) * frameCount );
//  
point( wvStart+buf+in.right.get(651) * frameCount, cY+in.left.get(651) * frameCount);
//  
point( wvStart+buf+in.left.get(652) * frameCount, cY+in.right.get(652) * frameCount );
//  
point( wvStart+buf+in.right.get(653) * frameCount, cY+in.left.get(653) * frameCount);
//  
point( wvStart+buf+in.left.get(654) * frameCount, cY+in.right.get(654) * frameCount );
//  
point( wvStart+buf+in.right.get(655) * frameCount, cY+in.left.get(655) * frameCount);
//  
point( wvStart+buf+in.left.get(656) * frameCount, cY+in.right.get(656) * frameCount );
//  
point( wvStart+buf+in.right.get(657) * frameCount, cY+in.left.get(657) * frameCount);
//  
point( wvStart+buf+in.left.get(658) * frameCount, cY+in.right.get(658) * frameCount );
//  
point( wvStart+buf+in.right.get(659) * frameCount, cY+in.left.get(659) * frameCount);
//  
point( wvStart+buf+in.left.get(660) * frameCount, cY+in.right.get(660) * frameCount );
//  
point( wvStart+buf+in.right.get(661) * frameCount, cY+in.left.get(661) * frameCount);
//  
point( wvStart+buf+in.left.get(662) * frameCount, cY+in.right.get(662) * frameCount );
//  
point( wvStart+buf+in.right.get(663) * frameCount, cY+in.left.get(663) * frameCount);
//  
point( wvStart+buf+in.left.get(664) * frameCount, cY+in.right.get(664) * frameCount );
//  
point( wvStart+buf+in.right.get(665) * frameCount, cY+in.left.get(665) * frameCount);
//  
point( wvStart+buf+in.left.get(666) * frameCount, cY+in.right.get(666) * frameCount );
//  
point( wvStart+buf+in.right.get(667) * frameCount, cY+in.left.get(667) * frameCount);
//  
point( wvStart+buf+in.left.get(668) * frameCount, cY+in.right.get(668) * frameCount );
//  
point( wvStart+buf+in.right.get(669) * frameCount, cY+in.left.get(669) * frameCount);
//  
point( wvStart+buf+in.left.get(670) * frameCount, cY+in.right.get(670) * frameCount );
//  
point( wvStart+buf+in.right.get(671) * frameCount, cY+in.left.get(671) * frameCount);
//  
point( wvStart+buf+in.left.get(672) * frameCount, cY+in.right.get(672) * frameCount );
//  
point( wvStart+buf+in.right.get(673) * frameCount, cY+in.left.get(673) * frameCount);
//  
point( wvStart+buf+in.left.get(674) * frameCount, cY+in.right.get(674) * frameCount );
//  
point( wvStart+buf+in.right.get(675) * frameCount, cY+in.left.get(675) * frameCount);
//  
point( wvStart+buf+in.left.get(676) * frameCount, cY+in.right.get(676) * frameCount );
//  
point( wvStart+buf+in.right.get(677) * frameCount, cY+in.left.get(677) * frameCount);
//  
point( wvStart+buf+in.left.get(678) * frameCount, cY+in.right.get(678) * frameCount );
//  
point( wvStart+buf+in.right.get(679) * frameCount, cY+in.left.get(679) * frameCount);
//  
point( wvStart+buf+in.left.get(680) * frameCount, cY+in.right.get(680) * frameCount );
//  
point( wvStart+buf+in.right.get(681) * frameCount, cY+in.left.get(681) * frameCount);
//  
point( wvStart+buf+in.left.get(682) * frameCount, cY+in.right.get(682) * frameCount );
//  
point( wvStart+buf+in.right.get(683) * frameCount, cY+in.left.get(683) * frameCount);
//  
point( wvStart+buf+in.left.get(684) * frameCount, cY+in.right.get(684) * frameCount );
//  
point( wvStart+buf+in.right.get(685) * frameCount, cY+in.left.get(685) * frameCount);
//  
point( wvStart+buf+in.left.get(686) * frameCount, cY+in.right.get(686) * frameCount );
//  
point( wvStart+buf+in.right.get(687) * frameCount, cY+in.left.get(687) * frameCount);
//  
point( wvStart+buf+in.left.get(688) * frameCount, cY+in.right.get(688) * frameCount );
//  
point( wvStart+buf+in.right.get(689) * frameCount, cY+in.left.get(689) * frameCount);
//  
point( wvStart+buf+in.left.get(690) * frameCount, cY+in.right.get(690) * frameCount );
//  
point( wvStart+buf+in.right.get(691) * frameCount, cY+in.left.get(691) * frameCount);
//  
point( wvStart+buf+in.left.get(692) * frameCount, cY+in.right.get(692) * frameCount );
//  
point( wvStart+buf+in.right.get(693) * frameCount, cY+in.left.get(693) * frameCount);
//  
point( wvStart+buf+in.left.get(694) * frameCount, cY+in.right.get(694) * frameCount );
//  
point( wvStart+buf+in.right.get(695) * frameCount, cY+in.left.get(695) * frameCount);
//  
point( wvStart+buf+in.left.get(696) * frameCount, cY+in.right.get(696) * frameCount );
//  
point( wvStart+buf+in.right.get(697) * frameCount, cY+in.left.get(697) * frameCount);
//  
point( wvStart+buf+in.left.get(698) * frameCount, cY+in.right.get(698) * frameCount );
//  
point( wvStart+buf+in.right.get(699) * frameCount, cY+in.left.get(699) * frameCount);
//  
point( wvStart+buf+in.left.get(700) * frameCount, cY+in.right.get(700) * frameCount );
//  
point( wvStart+buf+in.right.get(701) * frameCount, cY+in.left.get(701) * frameCount);
//  
point( wvStart+buf+in.left.get(702) * frameCount, cY+in.right.get(702) * frameCount );
//  
point( wvStart+buf+in.right.get(703) * frameCount, cY+in.left.get(703) * frameCount);
//  
point( wvStart+buf+in.left.get(704) * frameCount, cY+in.right.get(704) * frameCount );
//  
point( wvStart+buf+in.right.get(705) * frameCount, cY+in.left.get(705) * frameCount);
//  
point( wvStart+buf+in.left.get(706) * frameCount, cY+in.right.get(706) * frameCount );
//  
point( wvStart+buf+in.right.get(707) * frameCount, cY+in.left.get(707) * frameCount);
//  
point( wvStart+buf+in.left.get(708) * frameCount, cY+in.right.get(708) * frameCount );
//  
point( wvStart+buf+in.right.get(709) * frameCount, cY+in.left.get(709) * frameCount);
//  
point( wvStart+buf+in.left.get(710) * frameCount, cY+in.right.get(710) * frameCount );
//  
point( wvStart+buf+in.right.get(711) * frameCount, cY+in.left.get(711) * frameCount);
//  
point( wvStart+buf+in.left.get(712) * frameCount, cY+in.right.get(712) * frameCount );
//  
point( wvStart+buf+in.right.get(713) * frameCount, cY+in.left.get(713) * frameCount);
//  
point( wvStart+buf+in.left.get(714) * frameCount, cY+in.right.get(714) * frameCount );
//  
point( wvStart+buf+in.right.get(715) * frameCount, cY+in.left.get(715) * frameCount);
//  
point( wvStart+buf+in.left.get(716) * frameCount, cY+in.right.get(716) * frameCount );
//  
point( wvStart+buf+in.right.get(717) * frameCount, cY+in.left.get(717) * frameCount);
//  
point( wvStart+buf+in.left.get(718) * frameCount, cY+in.right.get(718) * frameCount );
//  
point( wvStart+buf+in.right.get(719) * frameCount, cY+in.left.get(719) * frameCount);
//  
point( wvStart+buf+in.left.get(720) * frameCount, cY+in.right.get(720) * frameCount );
//  
point( wvStart+buf+in.right.get(721) * frameCount, cY+in.left.get(721) * frameCount);
//  
point( wvStart+buf+in.left.get(722) * frameCount, cY+in.right.get(722) * frameCount );
//  
point( wvStart+buf+in.right.get(723) * frameCount, cY+in.left.get(723) * frameCount);
//  
point( wvStart+buf+in.left.get(724) * frameCount, cY+in.right.get(724) * frameCount );
//  
point( wvStart+buf+in.right.get(725) * frameCount, cY+in.left.get(725) * frameCount);
//  
point( wvStart+buf+in.left.get(726) * frameCount, cY+in.right.get(726) * frameCount );
//  
point( wvStart+buf+in.right.get(727) * frameCount, cY+in.left.get(727) * frameCount);
//  
point( wvStart+buf+in.left.get(728) * frameCount, cY+in.right.get(728) * frameCount );
//  
point( wvStart+buf+in.right.get(729) * frameCount, cY+in.left.get(729) * frameCount);
//  
point( wvStart+buf+in.left.get(730) * frameCount, cY+in.right.get(730) * frameCount );
//  
point( wvStart+buf+in.right.get(731) * frameCount, cY+in.left.get(731) * frameCount);
//  
point( wvStart+buf+in.left.get(732) * frameCount, cY+in.right.get(732) * frameCount );
//  
point( wvStart+buf+in.right.get(733) * frameCount, cY+in.left.get(733) * frameCount);
//  
point( wvStart+buf+in.left.get(734) * frameCount, cY+in.right.get(734) * frameCount );
//  
point( wvStart+buf+in.right.get(735) * frameCount, cY+in.left.get(735) * frameCount);
//  
point( wvStart+buf+in.left.get(736) * frameCount, cY+in.right.get(736) * frameCount );
//  
point( wvStart+buf+in.right.get(737) * frameCount, cY+in.left.get(737) * frameCount);
//  
point( wvStart+buf+in.left.get(738) * frameCount, cY+in.right.get(738) * frameCount );
//  
point( wvStart+buf+in.right.get(739) * frameCount, cY+in.left.get(739) * frameCount);
//  
point( wvStart+buf+in.left.get(740) * frameCount, cY+in.right.get(740) * frameCount );
//  
point( wvStart+buf+in.right.get(741) * frameCount, cY+in.left.get(741) * frameCount);
//  
point( wvStart+buf+in.left.get(742) * frameCount, cY+in.right.get(742) * frameCount );
//  
point( wvStart+buf+in.right.get(743) * frameCount, cY+in.left.get(743) * frameCount);
//  
point( wvStart+buf+in.left.get(744) * frameCount, cY+in.right.get(744) * frameCount );
//  
point( wvStart+buf+in.right.get(745) * frameCount, cY+in.left.get(745) * frameCount);
//  
point( wvStart+buf+in.left.get(746) * frameCount, cY+in.right.get(746) * frameCount );
//  
point( wvStart+buf+in.right.get(747) * frameCount, cY+in.left.get(747) * frameCount);
//  
point( wvStart+buf+in.left.get(748) * frameCount, cY+in.right.get(748) * frameCount );
//  
point( wvStart+buf+in.right.get(749) * frameCount, cY+in.left.get(749) * frameCount);
//  
point( wvStart+buf+in.left.get(750) * frameCount, cY+in.right.get(750) * frameCount );
//  
point( wvStart+buf+in.right.get(751) * frameCount, cY+in.left.get(751) * frameCount);
//  
point( wvStart+buf+in.left.get(752) * frameCount, cY+in.right.get(752) * frameCount );
//  
point( wvStart+buf+in.right.get(753) * frameCount, cY+in.left.get(753) * frameCount);
//  
point( wvStart+buf+in.left.get(754) * frameCount, cY+in.right.get(754) * frameCount );
//  
point( wvStart+buf+in.right.get(755) * frameCount, cY+in.left.get(755) * frameCount);
//  
point( wvStart+buf+in.left.get(756) * frameCount, cY+in.right.get(756) * frameCount );
//  
point( wvStart+buf+in.right.get(757) * frameCount, cY+in.left.get(757) * frameCount);
//  
point( wvStart+buf+in.left.get(758) * frameCount, cY+in.right.get(758) * frameCount );
//  
point( wvStart+buf+in.right.get(759) * frameCount, cY+in.left.get(759) * frameCount);
//  
point( wvStart+buf+in.left.get(760) * frameCount, cY+in.right.get(760) * frameCount );
//  
point( wvStart+buf+in.right.get(761) * frameCount, cY+in.left.get(761) * frameCount);
//  
point( wvStart+buf+in.left.get(762) * frameCount, cY+in.right.get(762) * frameCount );
//  
point( wvStart+buf+in.right.get(763) * frameCount, cY+in.left.get(763) * frameCount);
//  
point( wvStart+buf+in.left.get(764) * frameCount, cY+in.right.get(764) * frameCount );
//  
point( wvStart+buf+in.right.get(765) * frameCount, cY+in.left.get(765) * frameCount);
//  
point( wvStart+buf+in.left.get(766) * frameCount, cY+in.right.get(766) * frameCount );
//  
point( wvStart+buf+in.right.get(767) * frameCount, cY+in.left.get(767) * frameCount);
//  
point( wvStart+buf+in.left.get(768) * frameCount, cY+in.right.get(768) * frameCount );
//  
point( wvStart+buf+in.right.get(769) * frameCount, cY+in.left.get(769) * frameCount);
//  
point( wvStart+buf+in.left.get(770) * frameCount, cY+in.right.get(770) * frameCount );
//  
point( wvStart+buf+in.right.get(771) * frameCount, cY+in.left.get(771) * frameCount);
//  
point( wvStart+buf+in.left.get(772) * frameCount, cY+in.right.get(772) * frameCount );
//  
point( wvStart+buf+in.right.get(773) * frameCount, cY+in.left.get(773) * frameCount);
//  
point( wvStart+buf+in.left.get(774) * frameCount, cY+in.right.get(774) * frameCount );
//  
point( wvStart+buf+in.right.get(775) * frameCount, cY+in.left.get(775) * frameCount);
//  
point( wvStart+buf+in.left.get(776) * frameCount, cY+in.right.get(776) * frameCount );
//  
point( wvStart+buf+in.right.get(777) * frameCount, cY+in.left.get(777) * frameCount);
//  
point( wvStart+buf+in.left.get(778) * frameCount, cY+in.right.get(778) * frameCount );
//  
point( wvStart+buf+in.right.get(779) * frameCount, cY+in.left.get(779) * frameCount);
//  
point( wvStart+buf+in.left.get(780) * frameCount, cY+in.right.get(780) * frameCount );
//  
point( wvStart+buf+in.right.get(781) * frameCount, cY+in.left.get(781) * frameCount);
//  
point( wvStart+buf+in.left.get(782) * frameCount, cY+in.right.get(782) * frameCount );
//  
point( wvStart+buf+in.right.get(783) * frameCount, cY+in.left.get(783) * frameCount);
//  
point( wvStart+buf+in.left.get(784) * frameCount, cY+in.right.get(784) * frameCount );
//  
point( wvStart+buf+in.right.get(785) * frameCount, cY+in.left.get(785) * frameCount);
//  
point( wvStart+buf+in.left.get(786) * frameCount, cY+in.right.get(786) * frameCount );
//  
point( wvStart+buf+in.right.get(787) * frameCount, cY+in.left.get(787) * frameCount);
//  
point( wvStart+buf+in.left.get(788) * frameCount, cY+in.right.get(788) * frameCount );
//  
point( wvStart+buf+in.right.get(789) * frameCount, cY+in.left.get(789) * frameCount);
//  
point( wvStart+buf+in.left.get(790) * frameCount, cY+in.right.get(790) * frameCount );
//  
point( wvStart+buf+in.right.get(791) * frameCount, cY+in.left.get(791) * frameCount);
//  
point( wvStart+buf+in.left.get(792) * frameCount, cY+in.right.get(792) * frameCount );
//  
point( wvStart+buf+in.right.get(793) * frameCount, cY+in.left.get(793) * frameCount);
//  
point( wvStart+buf+in.left.get(794) * frameCount, cY+in.right.get(794) * frameCount );
//  
point( wvStart+buf+in.right.get(795) * frameCount, cY+in.left.get(795) * frameCount);
//  
point( wvStart+buf+in.left.get(796) * frameCount, cY+in.right.get(796) * frameCount );
//  
point( wvStart+buf+in.right.get(797) * frameCount, cY+in.left.get(797) * frameCount);
//  
point( wvStart+buf+in.left.get(798) * frameCount, cY+in.right.get(798) * frameCount );
//  
point( wvStart+buf+in.right.get(799) * frameCount, cY+in.left.get(799) * frameCount);
//  
point( wvStart+buf+in.left.get(800) * frameCount, cY+in.right.get(800) * frameCount );
//  
point( wvStart+buf+in.right.get(801) * frameCount, cY+in.left.get(801) * frameCount);
//  
point( wvStart+buf+in.left.get(802) * frameCount, cY+in.right.get(802) * frameCount );
//  
point( wvStart+buf+in.right.get(803) * frameCount, cY+in.left.get(803) * frameCount);
//  
point( wvStart+buf+in.left.get(804) * frameCount, cY+in.right.get(804) * frameCount );
//  
point( wvStart+buf+in.right.get(805) * frameCount, cY+in.left.get(805) * frameCount);
//  
point( wvStart+buf+in.left.get(806) * frameCount, cY+in.right.get(806) * frameCount );
//  
point( wvStart+buf+in.right.get(807) * frameCount, cY+in.left.get(807) * frameCount);
//  
point( wvStart+buf+in.left.get(808) * frameCount, cY+in.right.get(808) * frameCount );
//  
point( wvStart+buf+in.right.get(809) * frameCount, cY+in.left.get(809) * frameCount);
//  
point( wvStart+buf+in.left.get(810) * frameCount, cY+in.right.get(810) * frameCount );
//  
point( wvStart+buf+in.right.get(811) * frameCount, cY+in.left.get(811) * frameCount);
//  
point( wvStart+buf+in.left.get(812) * frameCount, cY+in.right.get(812) * frameCount );
//  
point( wvStart+buf+in.right.get(813) * frameCount, cY+in.left.get(813) * frameCount);
//  
point( wvStart+buf+in.left.get(814) * frameCount, cY+in.right.get(814) * frameCount );
//  
point( wvStart+buf+in.right.get(815) * frameCount, cY+in.left.get(815) * frameCount);
//  
point( wvStart+buf+in.left.get(816) * frameCount, cY+in.right.get(816) * frameCount );
//  
point( wvStart+buf+in.right.get(817) * frameCount, cY+in.left.get(817) * frameCount);
//  
point( wvStart+buf+in.left.get(818) * frameCount, cY+in.right.get(818) * frameCount );
//  
point( wvStart+buf+in.right.get(819) * frameCount, cY+in.left.get(819) * frameCount);
//  
point( wvStart+buf+in.left.get(820) * frameCount, cY+in.right.get(820) * frameCount );
//  
point( wvStart+buf+in.right.get(821) * frameCount, cY+in.left.get(821) * frameCount);
//  
point( wvStart+buf+in.left.get(822) * frameCount, cY+in.right.get(822) * frameCount );
//  
point( wvStart+buf+in.right.get(823) * frameCount, cY+in.left.get(823) * frameCount);
//  
point( wvStart+buf+in.left.get(824) * frameCount, cY+in.right.get(824) * frameCount );
//  
point( wvStart+buf+in.right.get(825) * frameCount, cY+in.left.get(825) * frameCount);
//  
point( wvStart+buf+in.left.get(826) * frameCount, cY+in.right.get(826) * frameCount );
//  
point( wvStart+buf+in.right.get(827) * frameCount, cY+in.left.get(827) * frameCount);
//  
point( wvStart+buf+in.left.get(828) * frameCount, cY+in.right.get(828) * frameCount );
//  
point( wvStart+buf+in.right.get(829) * frameCount, cY+in.left.get(829) * frameCount);
//  
point( wvStart+buf+in.left.get(830) * frameCount, cY+in.right.get(830) * frameCount );
//  
point( wvStart+buf+in.right.get(831) * frameCount, cY+in.left.get(831) * frameCount);
//  
point( wvStart+buf+in.left.get(832) * frameCount, cY+in.right.get(832) * frameCount );
//  
point( wvStart+buf+in.right.get(833) * frameCount, cY+in.left.get(833) * frameCount);
//  
point( wvStart+buf+in.left.get(834) * frameCount, cY+in.right.get(834) * frameCount );
//  
point( wvStart+buf+in.right.get(835) * frameCount, cY+in.left.get(835) * frameCount);
//  
point( wvStart+buf+in.left.get(836) * frameCount, cY+in.right.get(836) * frameCount );
//  
point( wvStart+buf+in.right.get(837) * frameCount, cY+in.left.get(837) * frameCount);
//  
point( wvStart+buf+in.left.get(838) * frameCount, cY+in.right.get(838) * frameCount );
//  
point( wvStart+buf+in.right.get(839) * frameCount, cY+in.left.get(839) * frameCount);
//  
point( wvStart+buf+in.left.get(840) * frameCount, cY+in.right.get(840) * frameCount );
//  
point( wvStart+buf+in.right.get(841) * frameCount, cY+in.left.get(841) * frameCount);
//  
point( wvStart+buf+in.left.get(842) * frameCount, cY+in.right.get(842) * frameCount );
//  
point( wvStart+buf+in.right.get(843) * frameCount, cY+in.left.get(843) * frameCount);
//  
point( wvStart+buf+in.left.get(844) * frameCount, cY+in.right.get(844) * frameCount );
//  
point( wvStart+buf+in.right.get(845) * frameCount, cY+in.left.get(845) * frameCount);
//  
point( wvStart+buf+in.left.get(846) * frameCount, cY+in.right.get(846) * frameCount );
//  
point( wvStart+buf+in.right.get(847) * frameCount, cY+in.left.get(847) * frameCount);
//  
point( wvStart+buf+in.left.get(848) * frameCount, cY+in.right.get(848) * frameCount );
//  
point( wvStart+buf+in.right.get(849) * frameCount, cY+in.left.get(849) * frameCount);
//  
point( wvStart+buf+in.left.get(850) * frameCount, cY+in.right.get(850) * frameCount );
//  
point( wvStart+buf+in.right.get(851) * frameCount, cY+in.left.get(851) * frameCount);
//  
point( wvStart+buf+in.left.get(852) * frameCount, cY+in.right.get(852) * frameCount );
//  
point( wvStart+buf+in.right.get(853) * frameCount, cY+in.left.get(853) * frameCount);
//  
point( wvStart+buf+in.left.get(854) * frameCount, cY+in.right.get(854) * frameCount );
//  
point( wvStart+buf+in.right.get(855) * frameCount, cY+in.left.get(855) * frameCount);
//  
point( wvStart+buf+in.left.get(856) * frameCount, cY+in.right.get(856) * frameCount );
//  
point( wvStart+buf+in.right.get(857) * frameCount, cY+in.left.get(857) * frameCount);
//  
point( wvStart+buf+in.left.get(858) * frameCount, cY+in.right.get(858) * frameCount );
//  
point( wvStart+buf+in.right.get(859) * frameCount, cY+in.left.get(859) * frameCount);
//  
point( wvStart+buf+in.left.get(860) * frameCount, cY+in.right.get(860) * frameCount );
//  
point( wvStart+buf+in.right.get(861) * frameCount, cY+in.left.get(861) * frameCount);
//  
point( wvStart+buf+in.left.get(862) * frameCount, cY+in.right.get(862) * frameCount );
//  
point( wvStart+buf+in.right.get(863) * frameCount, cY+in.left.get(863) * frameCount);
//  
point( wvStart+buf+in.left.get(864) * frameCount, cY+in.right.get(864) * frameCount );
//  
point( wvStart+buf+in.right.get(865) * frameCount, cY+in.left.get(865) * frameCount);
//  
point( wvStart+buf+in.left.get(866) * frameCount, cY+in.right.get(866) * frameCount );
//  
point( wvStart+buf+in.right.get(867) * frameCount, cY+in.left.get(867) * frameCount);
//  
point( wvStart+buf+in.left.get(868) * frameCount, cY+in.right.get(868) * frameCount );
//  
point( wvStart+buf+in.right.get(869) * frameCount, cY+in.left.get(869) * frameCount);
//  
point( wvStart+buf+in.left.get(870) * frameCount, cY+in.right.get(870) * frameCount );
//  
point( wvStart+buf+in.right.get(871) * frameCount, cY+in.left.get(871) * frameCount);
//  
point( wvStart+buf+in.left.get(872) * frameCount, cY+in.right.get(872) * frameCount );
//  
point( wvStart+buf+in.right.get(873) * frameCount, cY+in.left.get(873) * frameCount);
//  
point( wvStart+buf+in.left.get(874) * frameCount, cY+in.right.get(874) * frameCount );
//  
point( wvStart+buf+in.right.get(875) * frameCount, cY+in.left.get(875) * frameCount);
//  
point( wvStart+buf+in.left.get(876) * frameCount, cY+in.right.get(876) * frameCount );
//  
point( wvStart+buf+in.right.get(877) * frameCount, cY+in.left.get(877) * frameCount);
//  
point( wvStart+buf+in.left.get(878) * frameCount, cY+in.right.get(878) * frameCount );
//  
point( wvStart+buf+in.right.get(879) * frameCount, cY+in.left.get(879) * frameCount);
//  
point( wvStart+buf+in.left.get(880) * frameCount, cY+in.right.get(880) * frameCount );
//  
point( wvStart+buf+in.right.get(881) * frameCount, cY+in.left.get(881) * frameCount);
//  
point( wvStart+buf+in.left.get(882) * frameCount, cY+in.right.get(882) * frameCount );
//  
point( wvStart+buf+in.right.get(883) * frameCount, cY+in.left.get(883) * frameCount);
//  
point( wvStart+buf+in.left.get(884) * frameCount, cY+in.right.get(884) * frameCount );
//  
point( wvStart+buf+in.right.get(885) * frameCount, cY+in.left.get(885) * frameCount);
//  
point( wvStart+buf+in.left.get(886) * frameCount, cY+in.right.get(886) * frameCount );
//  
point( wvStart+buf+in.right.get(887) * frameCount, cY+in.left.get(887) * frameCount);
//  
point( wvStart+buf+in.left.get(888) * frameCount, cY+in.right.get(888) * frameCount );
//  
point( wvStart+buf+in.right.get(889) * frameCount, cY+in.left.get(889) * frameCount);
//  
point( wvStart+buf+in.left.get(890) * frameCount, cY+in.right.get(890) * frameCount );
//  
point( wvStart+buf+in.right.get(891) * frameCount, cY+in.left.get(891) * frameCount);
//  
point( wvStart+buf+in.left.get(892) * frameCount, cY+in.right.get(892) * frameCount );
//  
point( wvStart+buf+in.right.get(893) * frameCount, cY+in.left.get(893) * frameCount);
//  
point( wvStart+buf+in.left.get(894) * frameCount, cY+in.right.get(894) * frameCount );
//  
point( wvStart+buf+in.right.get(895) * frameCount, cY+in.left.get(895) * frameCount);
//  
point( wvStart+buf+in.left.get(896) * frameCount, cY+in.right.get(896) * frameCount );
//  
point( wvStart+buf+in.right.get(897) * frameCount, cY+in.left.get(897) * frameCount);
//  
point( wvStart+buf+in.left.get(898) * frameCount, cY+in.right.get(898) * frameCount );
//  
point( wvStart+buf+in.right.get(899) * frameCount, cY+in.left.get(899) * frameCount);
//  
point( wvStart+buf+in.left.get(768) * frameCount, cY+in.right.get(768) * frameCount );
//  
point( wvStart+buf+in.right.get(901) * frameCount, cY+in.left.get(901) * frameCount);
//  
point( wvStart+buf+in.left.get(902) * frameCount, cY+in.right.get(902) * frameCount );
//  
point( wvStart+buf+in.right.get(903) * frameCount, cY+in.left.get(903) * frameCount);
//  
point( wvStart+buf+in.left.get(904) * frameCount, cY+in.right.get(904) * frameCount );
//  
point( wvStart+buf+in.right.get(905) * frameCount, cY+in.left.get(905) * frameCount);
//  
point( wvStart+buf+in.left.get(906) * frameCount, cY+in.right.get(906) * frameCount );
//  
point( wvStart+buf+in.right.get(907) * frameCount, cY+in.left.get(907) * frameCount);
//  
point( wvStart+buf+in.left.get(908) * frameCount, cY+in.right.get(908) * frameCount );
//  
point( wvStart+buf+in.right.get(909) * frameCount, cY+in.left.get(909) * frameCount);
//  
point( wvStart+buf+in.left.get(910) * frameCount, cY+in.right.get(910) * frameCount );
//  
point( wvStart+buf+in.right.get(911) * frameCount, cY+in.left.get(911) * frameCount);
//  
point( wvStart+buf+in.left.get(912) * frameCount, cY+in.right.get(912) * frameCount );
//  
point( wvStart+buf+in.right.get(913) * frameCount, cY+in.left.get(913) * frameCount);
//  
point( wvStart+buf+in.left.get(914) * frameCount, cY+in.right.get(914) * frameCount );
//  
point( wvStart+buf+in.right.get(915) * frameCount, cY+in.left.get(915) * frameCount);
//  
point( wvStart+buf+in.left.get(916) * frameCount, cY+in.right.get(916) * frameCount );
//  
point( wvStart+buf+in.right.get(917) * frameCount, cY+in.left.get(917) * frameCount);
//  
point( wvStart+buf+in.left.get(918) * frameCount, cY+in.right.get(918) * frameCount );
//  
point( wvStart+buf+in.right.get(919) * frameCount, cY+in.left.get(919) * frameCount);
//  
point( wvStart+buf+in.left.get(920) * frameCount, cY+in.right.get(920) * frameCount );
//  
point( wvStart+buf+in.right.get(921) * frameCount, cY+in.left.get(921) * frameCount);
//  
point( wvStart+buf+in.left.get(922) * frameCount, cY+in.right.get(922) * frameCount );
//  
point( wvStart+buf+in.right.get(923) * frameCount, cY+in.left.get(923) * frameCount);
//  
point( wvStart+buf+in.left.get(924) * frameCount, cY+in.right.get(924) * frameCount );
//  
point( wvStart+buf+in.right.get(925) * frameCount, cY+in.left.get(925) * frameCount);
//  
point( wvStart+buf+in.left.get(926) * frameCount, cY+in.right.get(926) * frameCount );
//  
point( wvStart+buf+in.right.get(927) * frameCount, cY+in.left.get(927) * frameCount);
//  
point( wvStart+buf+in.left.get(928) * frameCount, cY+in.right.get(928) * frameCount );
//  
point( wvStart+buf+in.right.get(929) * frameCount, cY+in.left.get(929) * frameCount);
//  
point( wvStart+buf+in.left.get(930) * frameCount, cY+in.right.get(930) * frameCount );
//  
point( wvStart+buf+in.right.get(931) * frameCount, cY+in.left.get(931) * frameCount);
//  
point( wvStart+buf+in.left.get(932) * frameCount, cY+in.right.get(932) * frameCount );
//  
point( wvStart+buf+in.right.get(933) * frameCount, cY+in.left.get(933) * frameCount);
//  
point( wvStart+buf+in.left.get(934) * frameCount, cY+in.right.get(934) * frameCount );
//  
point( wvStart+buf+in.right.get(935) * frameCount, cY+in.left.get(935) * frameCount);
//  
point( wvStart+buf+in.left.get(936) * frameCount, cY+in.right.get(936) * frameCount );
//  
point( wvStart+buf+in.right.get(937) * frameCount, cY+in.left.get(937) * frameCount);
//  
point( wvStart+buf+in.left.get(938) * frameCount, cY+in.right.get(938) * frameCount );
//  
point( wvStart+buf+in.right.get(939) * frameCount, cY+in.left.get(939) * frameCount);
//  
point( wvStart+buf+in.left.get(940) * frameCount, cY+in.right.get(940) * frameCount );
//  
point( wvStart+buf+in.right.get(941) * frameCount, cY+in.left.get(941) * frameCount);
//  
point( wvStart+buf+in.left.get(942) * frameCount, cY+in.right.get(942) * frameCount );
//  
point( wvStart+buf+in.right.get(943) * frameCount, cY+in.left.get(943) * frameCount);
//  
point( wvStart+buf+in.left.get(944) * frameCount, cY+in.right.get(944) * frameCount );
//  
point( wvStart+buf+in.right.get(945) * frameCount, cY+in.left.get(945) * frameCount);
//  
point( wvStart+buf+in.left.get(946) * frameCount, cY+in.right.get(946) * frameCount );
//  
point( wvStart+buf+in.right.get(947) * frameCount, cY+in.left.get(947) * frameCount);
//  
point( wvStart+buf+in.left.get(948) * frameCount, cY+in.right.get(948) * frameCount );
//  
point( wvStart+buf+in.right.get(949) * frameCount, cY+in.left.get(949) * frameCount);
//  
point( wvStart+buf+in.left.get(950) * frameCount, cY+in.right.get(950) * frameCount );
//  
point( wvStart+buf+in.right.get(951) * frameCount, cY+in.left.get(951) * frameCount);
//  
point( wvStart+buf+in.left.get(952) * frameCount, cY+in.right.get(952) * frameCount );
//  
point( wvStart+buf+in.right.get(953) * frameCount, cY+in.left.get(953) * frameCount);
//  
point( wvStart+buf+in.left.get(954) * frameCount, cY+in.right.get(954) * frameCount );
//  
point( wvStart+buf+in.right.get(955) * frameCount, cY+in.left.get(955) * frameCount);
//  
point( wvStart+buf+in.left.get(956) * frameCount, cY+in.right.get(956) * frameCount );
//  
point( wvStart+buf+in.right.get(957) * frameCount, cY+in.left.get(957) * frameCount);
//  
point( wvStart+buf+in.left.get(958) * frameCount, cY+in.right.get(958) * frameCount );
//  
point( wvStart+buf+in.right.get(959) * frameCount, cY+in.left.get(959) * frameCount);
//  
point( wvStart+buf+in.left.get(960) * frameCount, cY+in.right.get(960) * frameCount );
//  
point( wvStart+buf+in.right.get(961) * frameCount, cY+in.left.get(961) * frameCount);
//  
point( wvStart+buf+in.left.get(962) * frameCount, cY+in.right.get(962) * frameCount );
//  
point( wvStart+buf+in.right.get(963) * frameCount, cY+in.left.get(963) * frameCount);
//  
point( wvStart+buf+in.left.get(964) * frameCount, cY+in.right.get(964) * frameCount );
//  
point( wvStart+buf+in.right.get(965) * frameCount, cY+in.left.get(965) * frameCount);
//  
point( wvStart+buf+in.left.get(966) * frameCount, cY+in.right.get(966) * frameCount );
//  
point( wvStart+buf+in.right.get(967) * frameCount, cY+in.left.get(967) * frameCount);
//  
point( wvStart+buf+in.left.get(968) * frameCount, cY+in.right.get(968) * frameCount );
//  
point( wvStart+buf+in.right.get(969) * frameCount, cY+in.left.get(969) * frameCount);
//  
point( wvStart+buf+in.left.get(970) * frameCount, cY+in.right.get(970) * frameCount );
//  
point( wvStart+buf+in.right.get(971) * frameCount, cY+in.left.get(971) * frameCount);
//  
point( wvStart+buf+in.left.get(972) * frameCount, cY+in.right.get(972) * frameCount );
//  
point( wvStart+buf+in.right.get(973) * frameCount, cY+in.left.get(973) * frameCount);
//  
point( wvStart+buf+in.left.get(974) * frameCount, cY+in.right.get(974) * frameCount );
//  
point( wvStart+buf+in.right.get(975) * frameCount, cY+in.left.get(975) * frameCount);
//  
point( wvStart+buf+in.left.get(976) * frameCount, cY+in.right.get(976) * frameCount );
//  
point( wvStart+buf+in.right.get(977) * frameCount, cY+in.left.get(977) * frameCount);
//  
point( wvStart+buf+in.left.get(978) * frameCount, cY+in.right.get(978) * frameCount );
//  
point( wvStart+buf+in.right.get(979) * frameCount, cY+in.left.get(979) * frameCount);
//  
point( wvStart+buf+in.left.get(980) * frameCount, cY+in.right.get(980) * frameCount );
//  
point( wvStart+buf+in.right.get(981) * frameCount, cY+in.left.get(981) * frameCount);
//  
point( wvStart+buf+in.left.get(982) * frameCount, cY+in.right.get(982) * frameCount );
//  
point( wvStart+buf+in.right.get(983) * frameCount, cY+in.left.get(983) * frameCount);
//  
point( wvStart+buf+in.left.get(984) * frameCount, cY+in.right.get(984) * frameCount );
//  
point( wvStart+buf+in.right.get(985) * frameCount, cY+in.left.get(985) * frameCount);
//  
point( wvStart+buf+in.left.get(986) * frameCount, cY+in.right.get(986) * frameCount );
//  
point( wvStart+buf+in.right.get(987) * frameCount, cY+in.left.get(987) * frameCount);
//  
point( wvStart+buf+in.left.get(988) * frameCount, cY+in.right.get(988) * frameCount );
//  
point( wvStart+buf+in.right.get(989) * frameCount, cY+in.left.get(989) * frameCount);
//  
point( wvStart+buf+in.left.get(990) * frameCount, cY+in.right.get(990) * frameCount );
//  
point( wvStart+buf+in.right.get(991) * frameCount, cY+in.left.get(991) * frameCount);
//  
point( wvStart+buf+in.left.get(992) * frameCount, cY+in.right.get(992) * frameCount );
//  
point( wvStart+buf+in.right.get(993) * frameCount, cY+in.left.get(993) * frameCount);
//  
point( wvStart+buf+in.left.get(994) * frameCount, cY+in.right.get(994) * frameCount );
//  
point( wvStart+buf+in.right.get(995) * frameCount, cY+in.left.get(995) * frameCount);
//  
point( wvStart+buf+in.left.get(996) * frameCount, cY+in.right.get(996) * frameCount );
//  
point( wvStart+buf+in.right.get(997) * frameCount, cY+in.left.get(997) * frameCount);
//  
point( wvStart+buf+in.left.get(998) * frameCount, cY+in.right.get(998) * frameCount );
//  
point( wvStart+buf+in.right.get(999) * frameCount, cY+in.left.get(999) * frameCount);
//  
point( wvStart+buf+in.left.get(1000) * frameCount, cY+in.right.get(1000) * frameCount );
//  
point( wvStart+buf+in.right.get(1001) * frameCount, cY+in.left.get(1001) * frameCount);
//  
point( wvStart+buf+in.left.get(1002) * frameCount, cY+in.right.get(1002) * frameCount );
//  
point( wvStart+buf+in.right.get(1003) * frameCount, cY+in.left.get(1003) * frameCount);
//  
point( wvStart+buf+in.left.get(1004) * frameCount, cY+in.right.get(1004) * frameCount );
//  
point( wvStart+buf+in.right.get(1005) * frameCount, cY+in.left.get(1005) * frameCount);
//  
point( wvStart+buf+in.left.get(1006) * frameCount, cY+in.right.get(1006) * frameCount );
//  
point( wvStart+buf+in.right.get(1007) * frameCount, cY+in.left.get(1007) * frameCount);
//  
point( wvStart+buf+in.left.get(1008) * frameCount, cY+in.right.get(1008) * frameCount );
//  
point( wvStart+buf+in.right.get(1009) * frameCount, cY+in.left.get(1009) * frameCount);
//  
point( wvStart+buf+in.left.get(1010) * frameCount, cY+in.right.get(1010) * frameCount );
//  
point( wvStart+buf+in.right.get(1011) * frameCount, cY+in.left.get(1011) * frameCount);
//  
point( wvStart+buf+in.left.get(1012) * frameCount, cY+in.right.get(1012) * frameCount );
//  
point( wvStart+buf+in.right.get(1013) * frameCount, cY+in.left.get(1013) * frameCount);
//  
point( wvStart+buf+in.left.get(1014) * frameCount, cY+in.right.get(1014) * frameCount );
//  
point( wvStart+buf+in.right.get(1015) * frameCount, cY+in.left.get(1015) * frameCount);
//  
point( wvStart+buf+in.left.get(1016) * frameCount, cY+in.right.get(1016) * frameCount );
//  
point( wvStart+buf+in.right.get(1017) * frameCount, cY+in.left.get(1017) * frameCount);
//  
point( wvStart+buf+in.left.get(1018) * frameCount, cY+in.right.get(1018) * frameCount );
//  
point( wvStart+buf+in.right.get(1019) * frameCount, cY+in.left.get(1019) * frameCount);
//  
point( wvStart+buf+in.left.get(1020) * frameCount, cY+in.right.get(1020) * frameCount );
//  
point( wvStart+buf+in.right.get(1021) * frameCount, cY+in.left.get(1021) * frameCount);
//  
point( wvStart+buf+in.left.get(1022) * frameCount, cY+in.right.get(1022) * frameCount );
//  
point( wvStart+buf+in.right.get(1023) * frameCount, cY+in.left.get(1023) * frameCount);
//  



/////////////////////////////////////////////////////////////////////
//  COPY AND PASTE CODE FROM CodeWriter.pde
/////////////////////////////////////////////////////////////////////




    strokeWeight(random(QUARTER_PI,TWO_PI));


    line( wvStart+ buf-1, cY + inLeft,
          wvStart+ buf, cY + inRight );


  for (int i = 0; i < in.bufferSize(); i++)
  {
    inLeft = in.left.get(i) * frameCount;
    inRight = in.right.get(i) * frameCount;
    


 // SHADOW BOX HELP GIVE DEPTH TO THE WAVEFORM?
    strokeWeight(11);
    stroke(0,11);
    point(wvStart+ i, cY + inLeft);  
    point(wvStart+ i+1, cY + inRight);

    strokeWeight(random(QUARTER_PI,TWO_PI));


    stroke(random(255), 37, 37,alf);    
    point(wvStart+ i, cY + inLeft);
    stroke(random(255), 37, 37,alf);    
    point(wvStart+ i+1, cY + inRight);

    stroke(random(255), 37, 37,alf);    
    point(wvStart+ i, cY + inLeft);
    stroke(random(255), 37, 37,alf);    
    point(wvStart+ i+1, cY + inRight);

    line( wvStart+ i+1, cY + inLeft,
          wvStart+ i, cY + inRight );


    //  black
    stroke(#000000);
    point(wvStart+ i, cY + inLeft +2);
    point(wvStart+ i, cY + inRight +2);
    
    //  gray
    stroke(random(255));
    point(wvStart+ i, cY + inLeft +2.5);
    point(wvStart+ i, cY + inRight +2.5);
    
    //  white
    stroke(#FFFFFF);
    point(wvStart+ i, cY + inLeft +3);
    point(wvStart+ i, cY + inRight +3);



//    //  RED
//    stroke(#EF0000);
//    point(wvStart+ i, cY + inLeft +2);
//    point(wvStart+ i, cY + inRight +2);
//    
//    //  RED
//    stroke(#EF2012);
//    point(wvStart+ i, cY + inLeft +2.5);
//    point(wvStart+ i, cY + inRight +2.5);
//    
//    //  ORANGE
//    stroke(#EFA500);
//    point(wvStart+ i, cY + inLeft +3);
//    point(wvStart+ i, cY + inRight +3);
//    
//    
//    //  YELLOW
//    stroke(#EFEF00);
//    point(wvStart+ i, cY + inLeft +4);
//    point(wvStart+ i, cY + inRight +4);
//    
//    
//    //  GREEN
//    stroke(#20EF12);
//    point(wvStart+ i, cY + inLeft +5);
//    point(wvStart+ i, cY + inRight +5);
//        
//    //  BLUE
//    stroke(#1975EF);
//    point(wvStart+ i, cY + inLeft +6);
//    point(wvStart+ i, cY + inRight +6);
//    
//
//    //  INDIGO - too purple
//    //stroke(#176837);  //  #2E0854  #4B0082
//    stroke(#000037);
//    point(wvStart+ i, cY + inLeft +7);
//    point(wvStart+ i, cY + inRight +7);
//    
//    //  VIOLET -- too purple
////    stroke(#7500A1);
//    
//    stroke(#000011);
//    //  LEFT
//    point(wvStart+ i, cY + inLeft +8);
//    point(wvStart+ i, cY + inRight +8);

  }
  ////  DRAW WAVEFORM  ////

  


    x = cX - int( cos(radians(angle)) * sz +noise(frameCount) );
    y = cY - int( sin(radians(angle)) * sz +noise(frameCount) );
 
    strokeWeight(1);
    stroke(frameCount%2==0?0:255,alf);
    ellipse( cX, cY, angle+inLeft, angle+inRight );
 
    strokeWeight(14);
    fill(frameCount%2==0?0:255);
    stroke(frameCount%2==0?0:255);
    ellipse( x, y, 14, 14 );
    ellipse( width-x, height-y, 14, 14 );
 
    strokeWeight(9);
    stroke(frameCount%2==0?255:0);
    stroke(frameCount%2==0?255:0);
    ellipse( x, y, 9, 9 );
    ellipse( width-x, height-y, 9, 9 );
    
    strokeWeight(4);
    fill(random(255));
    stroke(random(255));
    ellipse( x, y, 4, 4 );
    ellipse( width-x, height-y, 4, 4 );
noFill();
//    strokeWeight(1+(inLeft+inRight));
//    stroke(random(255),alf/PI);
//    point( x, y );
//    point( width-x, height-y );
 
    if( frameCount % 90 == 0 ){
      sz+=15;
    }

    if( angle < width)
        angle+= 2+(inLeft+inRight);
    else
        angle = random(inLeft+inRight);
    
//     x = cX - int( cos(radians(angle)) * sz +noise(frameCount) );
//     y = cY - int( sin(radians(angle)) * sz +noise(frameCount) );

 
getFlowery( cX*inLeft, cY*inRight, 
            y-i, x-i,
            x+inLeft, y+inRight,
            inLeft+random(width-x), inRight+random(height-y) );
 

 
 
    if (i < (height/2) ) {
        i+=2;
    } else {
        i = 0; 
    }


    
  ////  STOPPER
  if ( frameCount > (width+height)) {
    exit();
  }
}


///////////////////////////////////////////////
//  bezier helper
void getFlowery(
  float x, float y,
  float x2, float y2,
  float x3, float y3, 
  float x4, float y4
)
{

    strokeWeight(12);
    stroke(#EF0000);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
 
    strokeWeight(6);
    stroke(#EFEF00);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
 
    strokeWeight(2);
    stroke(#000037);
    bezier( x, y, x2, y2, x3, y3, x4, y4);
}






///////////////////////////////////////////////////////////
//  End handler, saves png
void exit() 
{

  artDaily( "ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  System.gc();
  super.stop();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "AppleGaramond", 37 ) );  //  "TrajanPro-Bold"
  smooth();

  fill(#EFEFEF);
  text( " "+dailyMsg, -1, height-2);

  fill(0);
  text( " "+dailyMsg, 0, height-3);
}

