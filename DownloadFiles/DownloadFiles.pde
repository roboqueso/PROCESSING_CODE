/*

DownloadFiles.pde 


README:

Attached is a zip of Processing sketch DownloadFiles.pde.  Processing is a JAVA based creative programming language that requires the processing IDE or processing-java to execute from command line.  Processing is free software that is cross platform so this should work on Mac OSX as well as Windows.

Pre requisites:
- Processing version 3 or higher
- Unzip DownloadFiles.pde into a matching folder named DownloadFiles
- Network connection since this file downloads all GZIP files from https://datasets.imdbws.com


SETUP: 

1. Download and install Processing
    a. Visit https://processing.org/download/
    b. Pick installer for your platform
    c. Run installer package to install Processing

    NOTE: For Mac OSX you just get an app file which needs to be dropped into ~/Applications.
    Running it in place may be fine as well.

2. Unzip DownloadFiles.zip to directory on your machine.  You should have a folder named DownloadFiles and a single file inside named DownloadFiles.pde
  * Because JAVA, please be sure your DownloadFiles.pde exists inside of a folder of the same name.

3. Open Processing and set max memory to 8192MB
    a. Open Processing
    b. Processing Menu > Preferences > check “Increase maximum available memory to: ” and enter 8192
    c. OK out

4. Make sure Processing shows JAVA mode.  Open DownloadFiles.pde if not already open, hit RUN button.


USAGE:

As long as you have increased Processing's maximum available memory ( Step 3 from SETUP ), this sketch is good to be run.

Step 4 from SETUP is all that is required for this version of DownloadFiles.pde.


After hitting run,  DownloadFiles.pde should now do the following:

1. Pop a blank UI
  * watch the title bar for status updates as activity isn't on the drawing thread.

2. Check for the IMDB .gz files in your /data folder inside of DownloadFiles.
  * if /data and the IMBD .tz files are not there, this program will download and extract all .tz files

3. Parse out 1000 Non Adult movie titles and save to a CSV file in the same directory as DownloadFiles.pde

4. UI should disappear after completing and you should have a file named 1000_NonAdultImdbMovies.csv next to DownloadFiles.pde


* Be aware DownloadFiles.pde ensures all 7 IMDB .gzip files from https://datasets.imdbws.com/ are downloaded before parsing any data.
From start to finish this might take as long as ten minutes depending on your connection.  Typically it will be much faster.



SUPPORT:

Please contact fickes@adobe.com for any questions or problems

WARNING : Processing's default maximum virtual memory is 256MB.  At least one of the IMDB .GZ files are closer 
to 300MB.  Before running this sketch please set Processing's maximum memory to 8192 via Preferences.
 - Processing > Preferences > Checkbox "Increase maximum available memory to:" 8192MB
 - OK out
 - THEN run this sketch
*/


import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.GZIPInputStream;

String[] imdbFiles = {
  "https://datasets.imdbws.com/name.basics.tsv.gz", 
  "https://datasets.imdbws.com/title.akas.tsv.gz", 
  "https://datasets.imdbws.com/title.basics.tsv.gz", 
  "https://datasets.imdbws.com/title.crew.tsv.gz", 
  "https://datasets.imdbws.com/title.episode.tsv.gz", 
  "https://datasets.imdbws.com/title.principals.tsv.gz", 
  "https://datasets.imdbws.com/title.ratings.tsv.gz"
};
 
GzHandler gz = new GzHandler();

Table table;
int MAX_ROW_CT = 1001;  // including the header row


///////////////////////////////////////////////////////////////////////////////
void settings(){

  size(1024, 768);
}


///////////////////////////////////////////////////////////////////////////////
//  Check for IMDB tsv files in place and download if not in /data 
void setup()
{
  background(-1);
  
  try{
    //  loop through all files and 
    //  a. download and save to /data    
    //  b. unzip to /data

    //  Check to see if .TSVs are in place
    for(int f = 0; f < imdbFiles.length; f++)
    {
      //  full IMDB download path
      String fullName = imdbFiles[f];
      
      //  part into local save to /data/
      String gzf = sketchPath() + "/data/" + fullName.replace("https://datasets.imdbws.com/", "");
      
      //  parse save to .tz filename
      String outf = gzf.replace(".gz", "");

      //  Does .tsv already exist or need downloading?
      File tf = dataFile( outf );
      if( ! tf.isFile() )
      {
        //  debug
        debugMsg(f + " DOWNLOAD FILE " + fullName );        

//  TODO : move downloading to drawing thread to allow for spinner
        if( gz.GetAndUngzip( fullName, gzf , outf ) )
          debugMsg(outf + " SAVED!");
        else
          debugMsg(outf + " not saved??? wait longer or broken???" );

      //  MEMORY CLEANUP
      surface.setTitle( "\t ++ COLLECT GARBAGE ++ ");
      System.gc();
      delay(5000); // to allow GC do its job
        
      }
      else
      {
        debugMsg( f + " All good, already have " + outf + " downloaded!" );
      }
      
      
    
    }
  
  
    

    debugMsg("Parse "+(MAX_ROW_CT-1)+" NON ADULT movies from title.basics.tsv and save to CSV");

    //  c. PARSE DATA
    table = loadTable("title.basics.tsv", "header");

    
    if(table!=null)
    {      
      debugMsg(table.getRowCount() + " total rows in table");
      
      int rowCt = 0;
      String[] movieRows = new String[MAX_ROW_CT];
      
      //  CSV HEADER ROW
      movieRows[rowCt] = "tconst, primaryTitle";
      rowCt++;

//  TODO: join in other details from challenge

      // NOTE : use matchRows to filter out adult movies
      for (TableRow row : table.matchRows("0", "isAdult") ) 
      {
        //  do we have enough rows yet?
        if(rowCt < MAX_ROW_CT )
        {
          String tconst = row.getString("tconst");
          String primaryTitle = sanitizeString( row.getString("primaryTitle") );
          String csvRow = tconst + ", " + primaryTitle;

          movieRows[rowCt] = csvRow;
          
          debugMsg( rowCt + " - " + csvRow  );
          
          rowCt++; 
        }
        else
        {
          //  HACK - minus 1 to exclude header row
          String csvFile = (MAX_ROW_CT-1) + "_NonAdultImdbMovies.csv";

          //  SAVE CSV
          saveStrings( sketchPath() + "/" + csvFile, movieRows );

          movieRows = null;

          debugMsg("SAVE " + sketchPath() + "/" + csvFile );

          break;
        }
      }
      //  CLEANUP
      table.clearRows();
      table = null;
      

      
    }


  } 
  catch (Exception e)
  {
    e.printStackTrace();
    debugMsg("SETUP() EXC :: " + e.getMessage() );
    System.gc();
    noLoop();
  }
  
  
}


///////////////////////////////////////////////////////////////////////////////
//  *TEMP* showing temporary all done message
//  TODO: Visualize parsed TSV data before saving to CSV
void draw(){


  background(0x20EF19);
  textSize(75);
  text("DOWNLOADS COMPLETE!", 0, height/2 );
  debugMsg("DOWNLOAD, PARSE AND CSV COMPLETED!");



  //  BYE BYE
  noLoop();
  System.gc();
  exit();
}
 


// helpers to move
public void debugMsg(String msg)
{
    println( msg );
    surface.setTitle( msg );
}

public String sanitizeString(String dirtyMsg )
{
  String clean = dirtyMsg.replace("\t", "");
  clean = clean.replace("\n", "");
  clean = clean.replace(",", "");
  clean = clean.replace("\"", "");
  return clean;
}



///////////////////////////////////////////////////////////////////////////////

/**
  Class for handling GZIP files
  a. download and save
  b. ungzip
**/
public class GzHandler {

  
  /**
    Convenience helper to download and un-gzip files
  **/
  public boolean GetAndUngzip( String downFile, String saveTo , String outFile )
  {
    try
    {     
      //  get file
      download( downFile, saveTo );
      
      //  ungzip file
      ungzip(saveTo, outFile );
    
    println( "\t  DONE >> GetAndUngzip()!!!" );
    
      return true;
    }
    catch(Exception e)
    {
      e.printStackTrace();
      println("GetAndUngzip EXC : " + e.getMessage() );
      return false;
    }
  }
  

  /**
  UnGzip specified @gzFile to @outFile
  **/
  public void download(String downFile, String saveTo ) 
    {
      try{
      
      println("downloading " + downFile + " ... ");
      surface.setTitle("downloading " + downFile + " ... ");
        
      // Open a file and read its binary data 
      byte b[] = loadBytes( downFile ); 
      
      if( b.length > 0 )
      {
        println("saving " + saveTo + " ... ");
        
        //  save file
        // Writes the bytes to a file
        saveBytes( saveTo, b );
      }
      
      //  cleanup
      b = null;
      surface.setTitle( "\t ++ COLLECT GARBAGE ++ ");
      System.gc();
      delay(5000); // to allow GC do its job
      
      println( "DONE >> " + downFile + " downloaded to " + saveTo );
      surface.setTitle( "DONE >> " + downFile + " downloaded to " + saveTo );
      
      }
      catch(Exception e ){
          e.printStackTrace();
          println("DOWNLOAD EXC: \n" + e.getMessage() + "\n" );
      
      }
    }
    
  /**
    UnGzip specified @gzFile to @outFile
  **/
  public void ungzip(String gzFile, String outFile ) 
    {
        // GZip input and output file.
        String sourceFile = gzFile;
        String targetFile = outFile;

        try {
            // Create a file input stream to read the source file.
            FileInputStream fis = new FileInputStream(sourceFile);

            // Create a gzip input stream to decompress the source
            // file defined by the file input stream.
            GZIPInputStream gzis = new GZIPInputStream(fis);
 
            // Create file output stream where the decompress result
            // will be stored.
            FileOutputStream fos = new FileOutputStream(targetFile);

            // Create a buffer and temporary variable used during the
            // file decompress process.
            byte[] buffer = new byte[1024];
            int length;

            // Read from the compressed source file and write the
            // decompress file.
            while ((length = gzis.read(buffer)) > 0) {
                fos.write(buffer, 0, length);
            }

            println( "\t DONE >> " + gzFile + " UNGZIPPED to " + outFile );
            surface.setTitle( "\t DONE >> " + gzFile + " UNGZIPPED to " + outFile );

            //  cleanup
            fis.close();
            fis = null;
            
            gzis.close();
            gzis = null;
            
            fos.close();
            fos = null;
            
            buffer = null;


            //  DELETE GZIP FILE
            File f = new File(sourceFile);
            if(f.exists())
              f.delete();

            f = null;
            
            surface.setTitle( "\t ++ COLLECT GARBAGE ++ ");
            System.gc();
            delay(5000); // to allow GC do its job
                    
            println( "\t  DONE >> " + gzFile + " DELETED!");
            surface.setTitle( "\t  DONE >> " + gzFile + " DELETED!");
            
        } catch (IOException e) {
            e.printStackTrace();
            println("GZIP EXC: \n" + e.getMessage() + "\n" );
        }
    }
}
/////////////////////////////////////////////////////////////////////////////// //<>// //<>//
