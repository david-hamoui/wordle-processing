char mode = 'h';
boolean reload = true;
String fWord;
char[][] tS = new char[6][5];
char[][] rC = new char[6][5];
int cSIndex = 0;
int cSRow = 0;
int time = 0;
int lineT = 0;
String[] fiveW;
boolean won = false;
boolean reloadEnd = true;



void setup(){
  size(500,700);
  background(210);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(50);
}


void draw(){
  time++;
  if (mode == 'h'){
    if (reload){
      
      background(210);
      
      fill(0);
      text("HOME",250,100);
      textSize(30);
      text("ACTIONS",250,300);
      
      reload = false;
    }
    
    if (button(250,400,100,40)){
      mode = 's';
      reload = true;
    }
    
    fill(0);
    text("PLAY",250,410);
    
  } else if (mode == 's') {
    String[] words = loadStrings("words.txt");
    int now = 0;
    for (int i = 0; i < words.length; i++){
      if (words[i].length() == 5){
         now++;
      }
    }
    String[] flWords = new String[now];
    int index = 0;
    for (int i = 0; i < words.length; i++){
      if (words[i].length() == 5){
         flWords[index] = words[i];
         index++;
      }
    }
    
    fiveW = flWords;
    
    fWord = flWords[int(random(now))];
    
    System.out.println(fWord);
    
    resetVars();
    
    mode = 'g';
  } else if (mode == 'g'){
    if (cSRow == 6) {
      mode = 'e';
    }
    
    if (reload) {
      background(210);
      fill(0);
      textSize(30);
      text("PLAY",250,100);
      //text(fWord,50,150);
      
      fill(255);
      stroke(0);
      for (int r = 0; r < 5; r++){
        for (int c = 0; c < 6; c++){
          if (rC[c][r] == '\0') {
            fill(255);
          } else if (rC[c][r] == 'y') {
            fill(255,255,0);
          } else if (rC[c][r] == 'g') {
            fill(0,255,0);
          }
          rect(85+r*82.5,220+c*82.5,70,70);
        }
      }
      
      reload = false;
    }
    
    if (mode != 'e') {
      if (keyPressed){
        if (key == ' '){
          if (cSIndex >= 5) {
            if (isItaWord()){
              if (cSRow != 5) {
                cSIndex = 0;
                analyze();
                cSRow++;
                reload = true;
              } else {
                analyze();
                cSRow++;
                reload = true;
              }
            } else {
              fill(100,0,0);
              textSize(22);
              text("It is not a word! Try again...", 350,150);
            }
          }
        } else {
          if (time > 16){
            time = 0;
            if (key == ''){
              if (cSIndex > 0){
                tS[cSRow][cSIndex-1] = '\0';
                cSIndex--;
              }
            } else {
              if (cSIndex < 5) {
                tS[cSRow][cSIndex] = key;
                cSIndex++;
              }
            }
            reload = true;
          }
        }
      }
    }
    
    textSize(50);
    fill(0);
    for (int r = 0; r < 6; r++){
      for (int c = 0; c < 5; c++) {
        if (tS[r][c] == '\0'){
        } else {
          text(tS[r][c],85+c*82.5,235 + r*82.5);
        }
      }
    }
    
  } else if (mode == 'e') {
    if (reloadEnd) {
      fill(210);
      rect(250,350,300,400);
      
      textSize(60);
      if (won){
        fill(0,100,0);
        text("YOU WON!", 250,300);
      } else {
        fill(100,0,0);
        text("YOU LOST!",250,250);
        textSize(20);
        text("the word was: ",200,350);
        textSize(35);
        text(fWord,315,350);
      }
      reloadEnd = false;
      
    }
    
    if (button(250,400,150,40)){
      mode = 's';
      reload = true;
    }
    if (button(250,450,100,40)){
      mode = 'h';
      reload = true;
    }
    
    fill(0);
    textSize(30);
    text("PLAY AGAIN",250,410);
    text("HOME",250,460);
    
  }
}


void analyze(){
  
  int analyzedChars[] = {-1, -1, -1, -1, -1};
  int correctChars = 0;
  int tempI = 0;
  
  for (int i = 0; i < 5; i++){
    char tempChar = tS[cSRow][i];
    
    if (tempChar == fWord.charAt(i)){
      rC[cSRow][i] = 'g';
      analyzedChars[tempI] = i;
      tempI++;
      correctChars++;
    }
    
  }
  
  for (int i = 0; i < 5; i++) {
    char tempChar = tS[cSRow][i];
      
    for (int a = 0; a < 5; a++){
      boolean temp = false;
      
      for (int m = 0; m < 5; m++) {
        if (a == analyzedChars[m]){
          temp = true;
        }
      }
      
      if (!temp && tempChar == fWord.charAt(a)){
        rC[cSRow][i] = 'y';
        analyzedChars[tempI] = a;
        tempI++;
        break;
      }
      
    }
    
  }
  
  if (correctChars == 5){
    won = true;
    cSRow = 5;
  }
  
}


boolean isItaWord(){
  
  
  String s = new String(tS[cSRow]);
  
  for (int i = 0; i < fiveW.length; i++){
    if (s.equals(fiveW[i])){
      return true;
    }
  }
  return false;
}


void printTs(char[][] array){
  for (int r = 0; r < 6; r++) {
    for (int c = 0; c < 5; c++) {
      System.out.print(array[r][c] + ", ");
    }
    System.out.println();
  }
}


boolean button(int xpos, int ypos, int xsize, int ysize){
  if (xpos-xsize/2 < mouseX && xpos+xsize/2 > mouseX && ypos-ysize/2 < mouseY && ypos+ysize/2 > mouseY){
    fill(200,200,10);
    if (mousePressed){
      return true;
    }
  } else {
    fill(255);
  }
  
  stroke(0);
  rect(xpos,ypos,xsize,ysize,8);
  return false;
}


void resetVars(){
  reload = true;
  tS = new char[6][5];
  rC = new char[6][5];
  cSIndex = 0;
  cSRow = 0;
  time = 0;
  lineT = 0;
  won = false;
  reloadEnd = true;
}
