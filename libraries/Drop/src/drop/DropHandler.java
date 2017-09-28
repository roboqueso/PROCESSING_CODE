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

import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.dnd.DnDConstants;
import java.awt.dnd.DropTargetDragEvent;
import java.awt.dnd.DropTargetDropEvent;
import java.awt.dnd.DropTargetEvent;
import java.awt.dnd.DropTargetListener;
import java.io.File;
import java.util.Iterator;


/**
 * adopted from:
 * http://www.java2s.com/Code/Java/Swing-JFC/DropTargetTest.htm
 * how to sign an applet:
 * http://java.sun.com/developer/technicalArticles/Security/Signed/
 *
 * @invisible
 */
public class DropHandler
    implements DropTargetListener {

  private final SDrop _mySDrop;

  /**
   * @invisible
   * @param theSDrop SDrop
   */
  public DropHandler(SDrop theSDrop) {
    _mySDrop = theSDrop;
  }


  /**
   * @invisible
   * @param event DropTargetDragEvent
   */
  public void dragEnter(DropTargetDragEvent event) {
    int a = event.getDropAction();
    if ((a & DnDConstants.ACTION_COPY) != 0) {
      if(SDrop.DEBUG) {
        System.out.println("ACTION_COPY\n");
      }
    }
    if ((a & DnDConstants.ACTION_MOVE) != 0) {
      if(SDrop.DEBUG) {
        System.out.println("ACTION_MOVE\n");
      }
    }
    if ((a & DnDConstants.ACTION_LINK) != 0) {
      if(SDrop.DEBUG) {
        System.out.println("ACTION_LINK\n");
      }
    }
    if (!isDragAcceptable(event)) {
      event.rejectDrag();
      return;
    }
  }

  /**
   * @invisible
   * @param event DropTargetEvent
   */
  public void dragExit(DropTargetEvent event) {
  }


  /**
   * @invisible
   * @param event DropTargetDragEvent
   */
  public void dragOver(DropTargetDragEvent event) {
    // you can provide visual feedback here
    if(_mySDrop.getDropListeners().size()>0) {
      _mySDrop.updateDropListener((float)event.getLocation().getX(),(float)event.getLocation().getY());
    }
  }


  /**
   * @invisible
   * @param event DropTargetDragEvent
   */
  public void dropActionChanged(DropTargetDragEvent event) {
    if (!isDragAcceptable(event)) {
      event.rejectDrag();
      return;
    }
  }


  /**
   * drop event is yet a mess. check single and multiple drops
   * from system and from browser. check each single possibility,
   * like image, text, bookmark, ...
   * @invisible
   * @param event DropTargetDropEvent
   */
  public void drop(DropTargetDropEvent event) {

    boolean DEBUG = false;

    DropEvent myDropEvent = new DropEvent(_mySDrop, event);

    event.acceptDrop(DnDConstants.ACTION_MOVE);

    Transferable transferable = event.getTransferable();

    DataFlavor[] flavors = transferable.getTransferDataFlavors();
    for (int i = 0; i < flavors.length; i++) {
      DataFlavor d = flavors[i];
      if (DEBUG) {
        System.out.println("MIME type=" + d.getMimeType() + "\n");
      }
      try {
        if (d.equals(DataFlavor.javaFileListFlavor)) {
          java.util.List<File> fileList = (java.util.List<File>) transferable.getTransferData(d);
          Iterator<File> iterator = fileList.iterator();
          while (iterator.hasNext()) {
            myDropEvent = new DropEvent(_mySDrop,event);
            File f = iterator.next();
            myDropEvent.setFile(f);
            myDropEvent.setDropEvent(event);
            myDropEvent.process();

          }
        }
        if (d.equals(DataFlavor.imageFlavor)) {
          myDropEvent = new DropEvent(_mySDrop,event);
        }

        if (d.equals(DataFlavor.stringFlavor)) {
          myDropEvent = new DropEvent(_mySDrop,event);
          String s = (String) transferable.getTransferData(d);
          if (s.toLowerCase().startsWith("file://") || s.toLowerCase().startsWith("http://") || s.toLowerCase().startsWith("https://")) {
            String[] myUrl = s.split("\n");
            if(myUrl.length>0) {
              s = myUrl[0];
            }
            if ((s.toLowerCase().indexOf(".jpg")>-1) ||
                (s.toLowerCase().indexOf(".jpeg")>-1) ||
                (s.toLowerCase().indexOf(".gif")>-1) ||
                (s.toLowerCase().indexOf(".png")>-1)) {
              myDropEvent.setImage(true);
            }

            myDropEvent.setURL(s);
          }
          myDropEvent.setText(s);
          myDropEvent.process();
        }
        myDropEvent.setDropEvent(event);

      } catch (Exception e) {
        System.out.println("Error: " + e + "\n");
      }
    }
    event.dropComplete(true);
  }

  /**
   * @invisible
   * @param event DropTargetDragEvent
   * @return boolean
   */
  public boolean isDragAcceptable(DropTargetDragEvent event) {
    return (event.getDropAction() & DnDConstants.ACTION_COPY_OR_MOVE) != 0;
  }

  /**
   * @invisible
   * @param event DropTargetDropEvent
   * @return boolean
   */
  public boolean isDropAcceptable(DropTargetDropEvent event) {
    return (event.getDropAction() & DnDConstants.ACTION_COPY_OR_MOVE) != 0;
  }
}
