package drop;

/**
 * 
 * drop is a processing and java library for dragging and dropping
 * things over an awt window.
 * 
 * 
 *
 *  Originally: 2007 by Andreas Schlegel
 *  Made compatible with Processing 3 by Ramin Soleymni
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation; either version 2.1
 * of the License, or (at your option) any later version.
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General
 * Public License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA 02111-1307 USA
 *
 * @author Andreas Schlegel (http://www.sojamo.de)
 * @author Ramin Soleymani (http://diskordier.net)
 */

import java.awt.Component;
import java.awt.dnd.DropTargetDropEvent;
import java.io.File;
import java.io.FilenameFilter;
import java.util.Collection;
import java.util.Vector;

import processing.core.PApplet;
import processing.core.PImage;


/**
 * a drop event will be returned to processing whenever you drop
 * a file or a folder onto your running sketch or application.
 * @example dropBasics
 */
public class DropEvent {

  private boolean isFile = false;

  private boolean isImage = false;

  private boolean isURL = false;

  private File _myFile;

  private String _myURL = "";

  private String _myFilePath = "";

  private String _myString = "";

  SDrop drop;

  PApplet applet;
  
  protected DropTargetDropEvent _myDropTargetDropEvent;

  protected final Component _myComponent;

  protected final DropTargetDropEvent _myEvent;

  /**
   * 
   * @param theDrop
   * @param theEvent
   */
  protected DropEvent(SDrop theDrop, DropTargetDropEvent theEvent) {
    _myEvent = theEvent;
    drop = theDrop;
    applet = (PApplet) drop.parent;
    _myComponent = theEvent.getDropTargetContext().getComponent();
  }


  public String toString() {
    if (_myFilePath.length() > 0) {
      return _myFilePath;
    }
    return _myString;
  }


  /**
   * get the component of the drop event.
   * @return Component
   */
  public Component component() {
    return _myComponent;
  }


  /**
   * get the x coordinate where the object was dropped.
   * @return int
   */
  public int x() {
    return (int) _myEvent.getLocation().getX();
  }


  /**
   * get the y coordinate where the object was dropped.
   * @return int
   */
  public int y() {
    return (int) _myEvent.getLocation().getY();
  }


  protected void setFile(File theFile) {
    _myFile = theFile;
    isFile = (_myFile == null) ? false : true;
    if (_myFile != null) {
      _myFilePath = _myFile.getAbsolutePath();
    }
    String myFileName = theFile.toString().toLowerCase();
    if (SDrop.DEBUG) {
      System.out.println("setting file " + myFileName);
    }
    if (myFileName.toString().endsWith(".jpg") ||
        myFileName.toString().endsWith(".jpeg")
        || myFileName.toString().endsWith(".gif") ||
        myFileName.toString().endsWith(".png")) {
      isImage = true;
    }
  }


  protected void setURL(String theUrl) {
    isURL = true;
    _myURL = theUrl;
  }


  protected void setText(String theString) {
    _myString = theString;
  }


  protected void setImage(boolean theFlag) {
    isImage = theFlag;
  }


  protected void setDropEvent(DropTargetDropEvent theEvent) {
    _myDropTargetDropEvent = theEvent;
  }


  /**
   * get the DropTargetDropEvent of the drop event. take a look at the documentation at
   * <a href="http://java.sun.com/j2se/1.4.2/docs/api/java/awt/dnd/DropTargetDropEvent.html" target="_blank">api/java/awt/dnd/DropTargetDropEvent</a>
   * @return DropTargetDropEvent
   */
  public DropTargetDropEvent dropTargetDropEvent() {
    return _myDropTargetDropEvent;
  }


  /**
   * check if the drop event was of type java.io.File.
   * @example dropFilesAndFolders
   * @return boolean
   */
  public boolean isFile() {
    return isFile;
  }


  /**
   * check if drop event is an image of type java.awt.Image
   * @return boolean
   */
  public boolean isImage() {
    return isImage;
  }


  /**
   * check if drop event is an url, e.g. and url drag/dropped from a browser.
   * @return boolean
   */
  public boolean isURL() {
    return isURL;
  }


  /**
   * when dropping text onto the applet you can access the text with the
   * getText() method.
   * @example dropText
   * @return String
   */
  public String text() {
    return _myString;
  }


  /**
   * when dropping a file or a folder onto the applet you get a java File back.
   * for accessing the content of this file please see the java documentation at
   * <a href="http://java.sun.com/j2se/1.4.2/docs/api/java/io/File.html" target="_blank">api/java/io/File</a> before making a
   * call to the file() method, make sure the File is not null. you can check
   * this with the theDropEvent.isFile() method, which will return true or false.
   * @example dropFilesAndFolders
   * @return File
   */
  public File file() {
    return _myFile;
  }


  /**
   * if an URL was dropped onto the applet the url() method returns the same as
   * String.
   *
   * @return String
   */
  public String url() {
    return _myURL;
  }


  /**
   * filePath returns the absolute path of a file.
   *
   * @return String
   */
  public String filePath() {
    return _myFilePath;
  }


  /**
   * @invisible
   * @param theFileReader void DropEvent
   */
  protected void process(DropImageReader theFileReader) {
    theFileReader.dispose();
    theFileReader = null;
    process();
  }


  protected void process() {
    drop.invokeDropEvent(this);
  }


  /**
   * load an image dragged from your hard disk and dropped onto your application into a PImage.
   * @return PImage
   */
  protected PImage loadImageFromDisk() {
    String myPath = file().toString().toLowerCase();
    if (myPath.startsWith("file://") || myPath.startsWith("http://") || myPath.startsWith("https://")) {
      _myURL = file().toString();
      return loadImageFromURL();
    }
    PImage theImage = new PImage(4, 4, PApplet.ARGB);
    new DropImageReader(this, theImage, new String[] {file().toString()});
    return theImage;
  }


  /**
   * load an image dragged from your browser and dropped onto your application into a PImage.
   * @return PImage
   */
  protected PImage loadImageFromURL() {
    PImage theImage = new PImage(4, 4, PApplet.ARGB);
    new DropImageReader(this, theImage, new String[] {url()});
    return theImage;
  }


  /**
   *
   * @param theImage PImage
   * @return PImage
   */
  protected PImage loadImageFromURL(PImage theImage) {
    if (theImage == null) {
      theImage = new PImage(4, 4, PApplet.ARGB);
    }
    new DropImageReader(this, theImage, new String[] {url()});
    return theImage;
  }


  /**
   * load an image from an URL or from a harddisk. before calling loadImage(), check
   * with isImage() if there is an image available.
   *
   * @return PImage
   * @related isImage ( )
   * @example dropLoadImage
   */
  public PImage loadImage() {
    if (isImage()) {
      if (isURL()) {
        return loadImageFromURL();
      } else {
        return loadImageFromDisk();
      }
    }
    return null;
  }


  /**
   * list files in a folder, recursive is optional, use true or false.
   * to list with a limited depth use an int between 0 and n.
   *
   * taken from http://snippets.dzone.com/posts/show/1875
   *
   * @example dropFilesAndFolders
   * @param directory File
   * @param filter FilenameFilter
   * @param recurse boolean
   * @return File[]
   */
  public static File[] listFilesAsArray(
      File directory,
      FilenameFilter filter,
      boolean recurse) {
    Collection<File> files = listFiles(directory, filter, recurse);

    File[] arr = new File[files.size()];
    return files.toArray(arr);
  }

  /**
   * 
   * @param directory
   * @param recurse
   * @return File[] DropEvent
   */
  public static File[] listFilesAsArray(
      File directory,
      boolean recurse) {
    return listFilesAsArray(directory,null,recurse);
  }

  /**
   * 
   * @param directory
   * @param filter
   * @param theDepthLimit
   * @return File[] DropEvent
   */
  public static File[] listFilesAsArray(
      File directory,
      FilenameFilter filter,
      int theDepthLimit) {
    Collection<File> files = listFiles(directory, filter, theDepthLimit);

    File[] arr = new File[files.size()];
    return files.toArray(arr);
  }

  
  /**
   * 
   * @param directory
   * @param theDepthLimit
   * @return File[] DropEvent
   */
  public static File[] listFilesAsArray(
      File directory,
      int theDepthLimit) {
    return listFilesAsArray(directory,null,theDepthLimit);
  }



  /**
   * list files in a folder, recursive is optional, use true or false.
   * to list with a limited depth use an int between 0 and n.
   *
   * taken from http://snippets.dzone.com/posts/show/1875
   * @example dropFilesAndFolders
   * @param directory File
   * @param filter FilenameFilter
   * @param recurse boolean
   * @return Collection
   */
  public static Collection<File> listFiles(
      File directory,
      FilenameFilter filter,
      boolean recurse) {
    // List of files / directories
    Vector<File> files = new Vector<File>();

    // Get files / directories in the directory
    File[] entries = directory.listFiles();

    // Go over entries
    for (File entry : entries) {
      // If there is no filter or the filter accepts the
      // file / directory, add it to the list
      if (filter == null || filter.accept(directory, entry.getName())) {
        files.add(entry);
      }

      // If the file is a directory and the recurse flag
      // is set, recurse into the directory
      if (recurse && entry.isDirectory()) {
        files.addAll(listFiles(entry, filter, recurse));
      }
    }

    // Return collection of files
    return files;
  }

  public static Collection<File> listFiles(
      File directory,
      boolean recurse) {
    return listFiles(directory,null,recurse);
  }


  public static Collection<File> listFiles(
      File directory,
      FilenameFilter filter,
      int theDepthLimit) {
    // List of files / directories
    Vector<File> files = new Vector<File>();

    // Get files / directories in the directory
    File[] entries = directory.listFiles();

    // Go over entries
    for (File entry : entries) {
      // If there is no filter or the filter accepts the
      // file / directory, add it to the list
      if (filter == null || filter.accept(directory, entry.getName())) {
        files.add(entry);
      }

      // If the file is a directory and the recurse flag
      // is set, recurse into the directory
      if ((theDepthLimit > 0) && entry.isDirectory()) {
        theDepthLimit--;
        files.addAll(listFiles(entry, filter, theDepthLimit));
        theDepthLimit++;
      }

    }

    // Return collection of files
    return files;
  }

  public static Collection<File> listFiles(
      File directory,
      int theDepthLimit) {
    return listFiles(directory,null,theDepthLimit);
  }


}
