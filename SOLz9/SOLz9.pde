//  SEE:    https://ello.co/ericfickes/post/tdkcnxdvxhlvv1spkot6xg
//  GOTO:  https://github.com/ericfickes/FIXLIB
import fixlib.*;

Fixlib fix = Fixlib.init(this);




Boolean isFinal = true;
int ctMAIN = 0;
int alf = 13;

int cX;
int cY;
int xx = 0;
int yy = 0;

int outerXX = 0;
int outerYY = 0;

int pad = 69;
int cubeSize = 50;

float angle = 0;
float maxAngle;
float radius = 9;
float outerRadius;

int offsetX = 0;
int offsetY = 0;

color[] p1 = { 
 #131213, #3c3b3c, #3d3c3d, #494849, #3f3c3e, #383637, #706e6f, #333132, #3d3b3c, #161616, #201f1f, #222222, #2a2828, #2e2d2d, #2f2e2e,
  #2C0E0F,#C98599,#F6EDF9,#6C2C2A,#50262B,#966576,#926E89,#BB8595,#CD91AB,#905869,#BC7B95,#8F4D52,#EB774C,#AD4932,#AA6878,#BA7379,#B76A79,#AF534D,#CA8589,#734650,#C87477,#EB8969,#D68674,#B28DAE,#C67B94,#613540,#D3B6D8,#F28753,#B46751,#CE562E,#DC7457,#C96769,#DA7865,#745268,#481411,#AB7388,#D96535,#8C3428,#DA6946,#AB6B85,#EA6B36,#AB5965,#BA6767,#CB7568,#B66B84,#CB6856,#D86A55,#A86667,#D88789,#D7A4B3,#B69DC7,#A67895,#C96A74,#D8979A,#76678B,#C55845,#6A221B,#F8A674,#A97579,#9988B0,#D38A95,#CA6545,#B78576,#F0AB8E,#D77B87,#D98757,#D87976,#E87B60,#BA7466,#7E6377,#DC7445,#946456,#CB9699,#E8B3B8,#9278A1,#EC9783,#9B8595,#3F191E,#CA7557,#55211F,#5B404E,#D8A796,#DB9683,#A97DA6,#CA491D,#5F1712,#A67565,#753D3A,#F4823C,#C79588,#C67544,#BBA6BC,#D26B65,#5E4A63,#E35C29,#8A3F40,#F8A55C,#865E82,#F0C5BB,#C0595F,#7D6059,#E2A076,#E19CA9,#D27B99,#E2531D,#BA3B15,#A26B90,#BB9F9B,#7F80A2,#442E3B,#C67B8C,#BD7384,#BD738C,#BD7B8C,#B57384,#B5738C,#C67B82,#C67384,#CE7B8E,#BD7C82,#CE7B81,#C6738C,#B47B8C,#B47C82,#CE7380,#CE738C,#C66B84,#F18B6E,#BA7489,#B189A9,#532527,#714A57,#CC8CA9,#DA94A9,#4B1513,#2E0D0C,#ED7052,#D9B5D6,#F2E6F4,#D78CA6,#DA848B,#8B342B,#8B4B51,#662725,#E997A8,#9C4237,#CA7B95,#E88C99,#BA6979,#EB959A,#956573,#D96A51,#D77B8A,#8D5766,#773534,#966F8E,#6A2118,#B04E47,#D88674,#EC7A62,#673233,#DA99B5,#CA7479,#E78988,#5D3843,#C86A78,#B3A1CB,#CD848B,#A96778,#CB95B7,#F0A9B2,#D97778,#C8584A,#763128,#DC7663,#67150C,#BA7578,#772821,#AD5968,#F8AA90,#4B1821,#DD949B,#CA6766,#F1845F,#D77B95,#CC94AC,#A86669,#F9979C,#B96769,#59211D,#CC5236,#D9A6C1,#927DA7,#32171D,#A8757D,#683129,#1C0707,#3B2327,#EC9683,#B66556,#CB7566,#662932,#7C688B,#FBA174,#7C423D,#D86864,#BA7568,#C16B84,#AB799B,#FA987C,#C98CB5,#BD857E,#873C3D,#DB9683,#D76B76,#96605D,#C35960,#F78C96,#AA7469,#C89598,#E27B82,#DA845D,#752931,#DAA79B,#F0C4CE,#825D7D,#F08C8C,#CB8E85,#5B1819,#C47BA5,#381A12,#D98CB5,#E56146,#412C3C,#D68494,#CE7B8C,#CE8494,#D68C9C,#CE849D,#C67384,#DE8C9C,#C47B8D,#D6849D,#DF8494,#DE8C93,#CF7386,#C4849F,#CE7B83,#C6738D,#D68C93,#CD8C9B,#DF849D,#C48493,#C57B83,#FFFFFF
  };
color[] p2 = { 
 
  #524a52, #645c64, #6e656e, #988d98, #938b93, #918a91, #938793, #887f88, #978e96, #5e555d, #7a7279, #7c6f7a, #6e686d, #685d66, #867c84, #92848f, #8b8289, #756872, #3e363c, #6a6268, #8b8088, #4e434b, #867b83, #756771, #645a61, #786e75, #978a93, #8b7f87, #564d53, #665d63, #7b7077, #756a71, #6d6369, #6e676b, #4f444a, #42383d, #655b60, #61545a, #a39199, #5e5559, #94888d, #706266, #73676a, #78676b, #685559, #9f858a, #908587, #a3868b, #6e5c5f, #684f53, #765c5e, #988586, #887475, #c6aeaf, #977c7d, #937475, #fefdfd, #fbf8f8, #6e5a5a, #9e8787, #766e6e, #8a8181, #867777, #847c7c, #705857, #6a5251, #7c6867, #907c7b, #bda2a0, #ae9593, #8d7775, #79605d, #dfcfcd, #f4edec, #6f6867, #b29692, #987772, #8e7470, #8e6c65, #af958f, #8a6c65, #ceb6b0, #887c79, #5a5655, #9c7970, #9f7e74, #816b64, #544641, #755c52, #8e6e5f, #605a57, #89827d, #7f766f, #a49a91, #55504b, #685f56, #78726a, #625d55, #7b7568, #78766e, #716e5f, #416e24, #365a28, #c9d950, #4c6c30, #659443, #729741, #698338, #587e3a, #385529, #5b7f3b, #89b552, #87a347, #4c7036, #5b7436, #446735, #689048, #87a24c, #56763b, #688c46, #849948, #84ab55, #70964c, #638c49, #8a9b49, #5b733a, #5f7f42, #82a756, #759750, #7e924a, #476639, #8e9e50, #425e35, #405a33, #92b362, #b3cd6f, #4b653a, #c0d472, #819b57, #4f6d40, #65854f, #c8d878, #8ca15c, #899c59, #a5be6d, #8aa965, #768c54, #84a464, #7d9a5e, #5a7549, #718753, #5a7449, #a6ca7e, #57754b, #435637, #405336, #8ca66b, #707a4d, #526542, #95a76b, #3f4a30, #a8bb78, #89ae74, #6c8c5e, #31422d, #96b176, #6f895d, #2b3b29, #87a06c, #7d9466, #8aa673, #8baf7b, #75855d, #849d70, #555f43, #8b9e71, #46543d, #5c694d, #5a6e52, #95ae81, #879f77, #748463, #7b9271, #718468, #606450, #91a082, #5c604e, #40483b, #505647, #545c4d, #2d2831, #514f5e, #797d6b, #5e5869, #656a5b, #4e4f44, #6d6e5f, #736b7e, #879582, #545360, #53515d, #707a6c, #706d7d, #504853, #888093, #a8b19d, #443d46, #585460, #786e7e, #484852, #51525c, #716775, #7c707f, #7a7281, #979787, #504f59, #625d69, #6b6471, #939c8c, #5b6359, #645c68, #625e6a, #7b7280, #474149, #46424a, #59525c, #837f8e, #655c67, #938797, #706773, #615963, #85808e, #6b6671, #706772, #787480, #636960, #616a65, #746f7a, #a396a5, #625b64, #817e8a, #6d7067, #8c818d, #7a7781, #beb6c5, #827c86, #5d575e, #96909b, #8d848e, #676168, #86838c, #99959f, #6a656b, #d7d4de, #7c7b80, #4e4d4f
 
  };

/* ------------------------------------------------------------------------- */
void  settings ()  {
    
    size(displayWidth, displayHeight, P2D);
    

    smooth(8);  //  smooth() can only be used in settings();
    pixelDensity(displayDensity());
}
/* ------------------------------------------------------------------------- */
void setup() {
  background (#031221);
  frameRate(420);


  fix.alpha(alf);

  noFill();

  cX = int( this.width / 2 );
  cY = int( this.height / 2 );

  xx = -cubeSize;
  yy = xx;  

  strokeWeight( .5 );

  offsetX = 400;
  offsetY = 400;
  
  //  max angle = where does the circle stop?
  maxAngle = 10000;

  outerRadius = width*height;

}


////////////////////////////////////////////////////
//
void draw()
{
  smooth();
  noFill();
  
  xx = ( offsetX - int( cos(radians(angle)) * radius ) );
  yy = ( offsetY - int( sin(radians(angle)) * radius ) );
  
  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );


  smooth();
  noFill();
  
  xx = ( offsetX - int( cos(radians(angle)) * radius ) );
  yy = ( offsetY - int( sin(radians(angle)) * radius ) );
  
  outerXX = ( offsetX - int( cos(radians(angle)) * outerRadius ) );
  outerYY = ( offsetY - int( sin(radians(angle)) * outerRadius ) );


if( frameCount % 12 == 0 ) {
  
      fix.ranPalStroke(p2);
      strokeWeight( alf );
      ellipse( xx, yy, random(outerXX), random(outerYY) );

      fix.ranPalStroke(p2);
      strokeWeight( alf*2 );
      line( xx, yy, outerXX+angle, outerYY+angle);

      strokeWeight( 55 );
      fix.ranPalStroke(p1);
    line( xx, yy, outerXX, outerYY);
    
    fix.ranPalStroke(p1);
    line( yy, xx, outerYY, outerXX);
}

if( angle % 360 == 0 ) {
      radius += fix.nextFib( int(alf) );
      outerRadius += alf;
}



  if( angle < 768 ) {
    angle++;
  } else if ( angle < 1200 )
    angle+=2;
  else
    angle += 3;


if( frameCount % 3 == 0 ) {
  
      strokeWeight( random(alf) );
      fix.ranPalStroke(p2);
      ellipse( xx, yy, random(outerXX), random(outerYY) );

      fix.ranPalStroke(p2);
      strokeWeight( 1.1); 
      ellipse( xx, yy, outerXX+angle, outerYY+angle);

      fix.ranPalStroke(p2);
      strokeWeight( .25 );
    line( xx, yy, outerXX, outerYY);

      fix.ranPalStroke(p1);
    strokeWeight(.25);
    ellipse( xx, yy, alf, alf );

      fix.ranPalStroke(p1);
    strokeWeight( .25 );          
    ellipse( xx, yy, outerYY, sin(outerXX) );
    line( xx, yy, outerYY, sin(outerXX) );
}

if( floor(angle) % 360 == 0 ) {
      radius *= 2;
      
      
      if(radius>height){
        radius= random( 50, 100 );
      }
      outerRadius += alf;
}

  angle += random(alf);

  if ( angle >= maxAngle )
  {
    doExit();
  }
}




///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{   
  artDaily("ERICFICKES.COM");


  save( fix.pdeName() + "-" + fix.getTimestamp()+".tif" );
  
  exit();

}



///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 15 );
  textFont( font );
  strokeWeight(1);

  stroke( #75EF19, 666 );
  text( " "+dailyMsg, this.width-175, this.height-15);
}



