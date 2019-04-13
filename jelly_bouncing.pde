int size = 9, i=0, j=0, n=1, l, m;
PVector[] pos = new PVector[size];
PVector[] rcmrel = new PVector[size];
PVector[][] relposvec = new PVector[size][size];
float[][] relpos = new float[size][size];
PVector[] vel = new PVector[size];
PVector[] acc = new PVector[size];
PVector[] force = new PVector[size];
float[] mass= new float[size];
float[] newleng = new float[size+3];
float[] radius = new float[size];
PVector g = new PVector(0, 9.8);
float dt = 0.05;
float k = 7000;
float b = 80;
float theta = -PI/4;
float k_floor = 10000;
float b_floor = 80;
float leng = 50;

void setup()
{
     size (500, 500);
     pos[0] = new PVector(250, 250);
     pos[1] = PVector.add(pos[0], new PVector(leng,0));
     pos[2] = PVector.add(pos[0], new PVector(leng,leng));
     pos[3] = PVector.add(pos[0], new PVector(0,leng));
     pos[4] = PVector.add(pos[0], new PVector(-leng,leng));
     pos[5] = PVector.add(pos[0], new PVector(-leng,0));
     pos[6] = PVector.add(pos[0], new PVector(-leng,-leng));
     pos[7] = PVector.add(pos[0], new PVector(0,-leng));
     pos[8] = PVector.add(pos[0], new PVector(leng,-leng));
     for (i=0 ; i<size; i++)
        {rcmrel[i]=PVector.sub(pos[i],pos[0]);
          for (int j=0;j<size;j++)
          {
            relposvec[i][j]=PVector.sub(pos[i],pos[j]);
            relpos[i][j] = PVector.sub(pos[i],pos[j]).mag();
          }
                  vel[i] = new PVector(0, 0);
                  acc[i] = new PVector(0, 0);
                  //damp_force[i] = new PVector(0, 0);
                  //spring_force[i] = new PVector(0, 0);
                  force[i] = new PVector(0, 0);
                  if (i!=0){
                  pushMatrix();
                  translate(pos[0].x, pos[0].y);
                  rcmrel[i].rotate(theta);
                  popMatrix();
                  }
                  radius[i] = 4;
                  mass[i] = 100; 
        } 
        
       for (i=0 ; i<size; i++){
         pos[i]=PVector.add(pos[0],rcmrel[i]);
       }
}


void draw()
{
background(255);
move();
diag();
spacingcheck();
collisioncheck();
saveFrame("output/task3_####.jpg");
}

void move(){
 for (i=0; i<size; i++)
 {
        acc[i] = PVector.add(PVector.div(force[i], mass[i]),g);
        vel[i].add(PVector.mult(acc[i], dt));
        pos[i].add(PVector.mult(vel[i], dt));
       
 }
}
void diag(){

fill(color(0));  
quad(pos[4].x,pos[4].y,pos[3].x,pos[3].y,pos[0].x,pos[0].y,pos[5].x,pos[5].y); 
quad(pos[3].x,pos[3].y,pos[2].x,pos[2].y,pos[1].x,pos[1].y,pos[0].x,pos[0].y); 
quad(pos[5].x,pos[5].y,pos[0].x,pos[0].y,pos[7].x,pos[7].y,pos[6].x,pos[6].y); 
quad(pos[0].x,pos[0].y,pos[1].x,pos[1].y,pos[8].x,pos[8].y,pos[7].x,pos[7].y); 
  for (i=0 ; i<size; i++)
{
  fill(255);
  ellipse(int (pos[i].x),int (pos[i].y), radius[i], radius[i]);
}
{
//fill(255);
//line(int (pos[0].x), int (pos[0].y), int (pos[1].x), int (pos[1].y));
//fill(255);
//line(int (pos[0].x), int (pos[0].y), int (pos[3].x), int (pos[3].y));
//fill(255);
//line(int (pos[0].x), int (pos[0].y), int (pos[5].x), int (pos[5].y));
//fill(255);
//line(int (pos[0].x), int (pos[0].y), int (pos[7].x), int (pos[7].y));
//fill(255);
//line(int (pos[1].x), int (pos[1].y), int (pos[2].x), int (pos[2].y));
//fill(255);
//line(int (pos[1].x), int (pos[1].y), int (pos[8].x), int (pos[8].y));
//fill(255);
//line(int (pos[2].x), int (pos[2].y), int (pos[3].x), int (pos[3].y));
//fill(255);
//line(int (pos[3].x), int (pos[3].y), int (pos[4].x), int (pos[4].y));
//fill(255);
//line(int (pos[4].x), int (pos[4].y), int (pos[5].x), int (pos[5].y));
//fill(255);
//line(int (pos[5].x), int (pos[5].y), int (pos[6].x), int (pos[6].y));
//fill(255);
//line(int (pos[6].x), int (pos[6].y), int (pos[7].x), int (pos[7].y));
//fill(255);
//line(int (pos[7].x), int (pos[7].y), int (pos[8].x), int (pos[8].y));
}
}

void collisioncheck(){
  for (i=0; i<size; i++)
     {   
       if ((pos[i].y > height) || (pos[i].y < 0.0)){ 
        force[i].y+=-k_floor*(pos[i].y-height)-b_floor*vel[i].y;
       }
     }
}

void spacingcheck(){
  //for (i=0; i<size; i++){
  //  if (PVector.sub(pos[0],pos[1]).mag()!=leng || PVector.sub(pos[0],pos[7]).mag()!=leng || PVector.sub(pos[0],pos[3]).mag()!=leng || PVector.sub(pos[0],pos[5]).mag()!=leng
  //   || PVector.sub(pos[8],pos[1]).mag()!=leng || PVector.sub(pos[8],pos[1]).mag()!=leng || PVector.sub(pos[1],pos[2]).mag()!=leng || PVector.sub(pos[2],pos[3]).mag()!=leng
  //   || PVector.sub(pos[3],pos[4]).mag()!=leng || PVector.sub(pos[4],pos[5]).mag()!=leng || PVector.sub(pos[5],pos[6]).mag()!=leng || PVector.sub(pos[6],pos[7]).mag()!=leng){
  forcecalc();
//    }
//}
}



void forcecalc(){
  for (i=0; i<size; i++)
{
    force[i] = new PVector(0, 0);
}
forcepairadd(0,1);
forcepairadd(0,3);
forcepairadd(0,5);
forcepairadd(0,7);
forcepairadd(1,2);
forcepairadd(2,3);
forcepairadd(3,4);
forcepairadd(4,5);
forcepairadd(5,6);
forcepairadd(6,7);
forcepairadd(7,8);
forcepairadd(3,7);
forcepairadd(4,6);
forcepairadd(2,8);
forcepairadd(4,2);
forcepairadd(5,1);
forcepairadd(6,8);
forcepairadd(2,6);
forcepairadd(4,8);
}


void forcepairadd(int m ,int n){
  PVector displacement = new PVector((pos[n].x - pos[m].x), (pos[n].y - pos[m].y));
  PVector unitdisplacement = new PVector((pos[n].x - pos[m].x), (pos[n].y - pos[m].y)).normalize();
  PVector damp_force = PVector.mult(unitdisplacement,(b*(vel[n].dot(unitdisplacement) - vel[m].dot(unitdisplacement))));
  PVector spring_force = PVector.mult(unitdisplacement,(k*(displacement.mag() - relpos[m][n])));
  PVector netforce = PVector.add(damp_force,spring_force);
  force[m].add(netforce);
  force[n].sub(netforce);
  
}
