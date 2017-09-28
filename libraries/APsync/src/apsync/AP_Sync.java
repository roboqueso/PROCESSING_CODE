/**
 * Arduino Processing Sync
 * AP-Sync it the easy way to sync data to processing from your arduino or any microcontroller to processing and back.
 * http://ap-sync.github.io
 *
 * Copyright (c) 2016 Nigel Tiany http://nigeltiany.com
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General
 * Public License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA  02111-1307  USA
 * 
 * @author      Nigel Tiany http://nigeltiany.com
 * @modified    09/10/2016
 * @version      (1.0.0)
 */

package apsync;


import processing.core.*;
import processing.serial.*;
import java.util.ArrayList;
import java.lang.reflect.Field; 


/**
 * This is a template class and can be used to start a new processing library or tool.
 * Make sure you rename this class as well as the name of the example package 'template' 
 * to your own library or tool naming convention.
 * 
 * (the tag example followed by the name of an example included in folder 'examples' will
 * automatically include the example in the javadoc.)
 *
 * @example Hello 
 */

public class AP_Sync implements Constants{
	  
  private Serial serial;
  private PApplet userSketch;
  private String data;
  private String testString = new String("Welcome to Arduino Processing Sync");
  private StringBuilder dataToSend;
  private StringBuilder SerialData = new StringBuilder();
  
  public AP_Sync(PApplet parent, String portName, int baudRate) {
    this.userSketch = parent;
    serial = new Serial(userSketch,portName,baudRate);
    userSketch.registerMethod("pre", this);
    userSketch.registerMethod("post", this);
    dataToSend = new StringBuilder();
    //PApplet.println("INITIALIZED");
  }
  
  public void pre(){
	  while(serial.available()>0){
	    char in = serial.readChar();
		//PApplet.print(in);
		if(in == dataEnd){
			SerialData.append(in);
			processData(SerialData.toString());
			SerialData = new StringBuilder();
		}else{
			SerialData.append(in);
		}	
	  }
  }
  
  public void post(){
	  if((dataToSend.toString().length()>0)){
		  serial.write(dataToSend.toString());
		  dataToSend = new StringBuilder();
	  }
  }
  
  
  @SafeVarargs
  public final <T> void send(T... data){
	//Sending one value
	if(data.length == 1){
		//dataToSend.append(String.valueOf(dataStart));	
		dataToSend.append(String.valueOf(data[0]));
		//dataToSend.append(String.valueOf(dataEnd));
		//dataToSend.append('\n');
	}else{ //its more than one value
		int dataNumber = 1;
		int limit = (data.length%2 == 0)? data.length-1:data.length;
	    for (int i=0; i<limit; i+=1){ //plus two once arduino gets sorted
	      //dataToSend.append(String.valueOf(dataStart));	
	      dataToSend.append(String.valueOf(data[i]));
	      dataToSend.append(String.valueOf(dataEnd));
	      if(dataNumber != data.length){ // for an even pair e.g send(name,value,name+1,value+1); this will never happen
	    	  //dataToSend.append(String.valueOf(valueStart));
	      }else{//So its is not an even pair // for un even data pair e.g. send(name,value,value); : dataNumber will be == to dataLength
	    	  //dataToSend.append(String.valueOf(dataEnd)); // Append that last value and get outta there
	    	  break;
	      }
		  //dataToSend.append(String.valueOf(data[i+1]));
		  //dataToSend.append(String.valueOf(dataEnd));
		  //dataToSend.append('\n');
		  //dataNumber += 2;
	    }
	}
  }
   
  void processData(String serialdata){
	  String variableName = "";
	  String type = "";
	  try{
		  variableName = serialdata.substring(serialdata.indexOf(dataStart)+1,serialdata.indexOf(valueStart));
		  String variableValue = serialdata.substring(serialdata.indexOf(valueStart)+1,serialdata.indexOf(dataEnd));
		  type = userSketch.getClass().getField(variableName).getGenericType().toString();
		  setValue(variableName,variableValue,type);
		  //PApplet.println(variableName + " Field type is " +type);
	  }catch(Exception x){
		  System.err.println("No public field named " + variableName + " in " + userSketch.getClass().getName());
	      type = (type.isEmpty()) ? "String" : type; //This might always be null actually :-\ mmmhhh
	      System.err.println("Try: public typeOf " + variableName +";"  + " >>  public "+ type + " " + variableName + "; perhaps.");
	  }
  }
  
  void setValue(String varname,String varvalue,String type){
	  try{
		  switch(type){
		  	case intInstance:
		  		userSketch.getClass().getField(varname).setInt(userSketch,Integer.valueOf(varvalue));
		  		break;
		  	case floatInstance:
		  		userSketch.getClass().getField(varname).setFloat(userSketch,Float.valueOf(varvalue));
		  		break;
		  	case charInstance:
		  		userSketch.getClass().getField(varname).setChar(userSketch,varvalue.charAt(0));
		  		break;
		  	case doubleInstance:
		  		userSketch.getClass().getField(varname).setDouble(userSketch, Double.valueOf(varvalue));
		  		break;
		  	case longInstance:
		  		userSketch.getClass().getField(varname).setLong(userSketch, Long.valueOf(varvalue));
		  		break;
		  	case booleanInstance:
		  		userSketch.getClass().getField(varname).setBoolean(userSketch, Boolean.parseBoolean(varvalue));
		  		break;
		  	case BooleanInstance:
		  		boolean value = (Integer.valueOf(Boolean.valueOf(varvalue).toString()) != 0)?true:false;
		  		userSketch.getClass().getField(varname).setBoolean(userSketch,value);
		  		break;
		  	default:
		  		userSketch.getClass().getField(varname).set(userSketch,varvalue);
		  		break;
		  }
	  }catch(Exception n){
		  System.err.println("Tried to set " + varname + " of type " + type.toUpperCase() + " to " + varvalue + " but it just can't happen.");
		  System.err.println("Please review the type definition of " + varname);
	  }
  }
  
//  /**
//   * Used by PApplet to shut things down.
//   */
//  public void dispose() {
//    serial.dispose();
//  }
}


