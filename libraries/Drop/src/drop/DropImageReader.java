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

import java.awt.Graphics;
import java.awt.GraphicsConfiguration;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.HeadlessException;
import java.awt.Image;
import java.awt.MediaTracker;
import java.awt.Transparency;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.PixelGrabber;
import java.util.Arrays;

import javax.swing.ImageIcon;

import processing.awt.PSurfaceAWT.SmoothCanvas;
import processing.core.PApplet;
import processing.core.PImage;

/**
 * @invisible
 */
public class DropImageReader implements Runnable {

	private final DropEvent _myDropEvent;

	private Thread _myThread;

	protected final static int LOAD_IMAGE_FROM_URL = 0;

	protected final static int LOAD_IMAGE_FROM_DISK = 1;

	private PImage _myImage;

	private String[] _myPath;

	protected DropImageReader(final DropEvent theDropEvent) {
		_myDropEvent = theDropEvent;
		start();
	}

	protected DropImageReader(final DropEvent theDropEvent,
			final PImage theDropImageLoader, final String[] thePath) {
		_myDropEvent = theDropEvent;
		_myImage = theDropImageLoader;
		_myPath = thePath;
		start();
	}

	public void start() {
		_myThread = new Thread(this);
		_myThread.start();
	}

	protected Image loadImage(Image img) {
		MediaTracker mt = new MediaTracker(_myDropEvent.drop.component);
		mt.addImage(img, 0);
		try {
			mt.waitForAll();
		} catch (InterruptedException e) {
			System.out.println("### ERROR " + e);
		} catch (Exception e) {
			System.out.println("### ERROR at loadImage " + e);
		}
		return img;
	}

	private void updatePImage(PImage theImage) {
		if (theImage.width > 0 && theImage.height > 0) {
			_myImage.init(theImage.width, theImage.height, theImage.format);
			_myImage.loadPixels();
			_myImage.pixels = theImage.pixels;
			_myImage.updatePixels();
		} else {
			System.out.println("### ERROR drop. unable to load image from "
					+ Arrays.toString(_myPath));
		}
	}

	public void run() {
		for (int i = 0; i < _myPath.length; i++) {
			PImage myImage = ((PApplet) _myDropEvent.drop.parent)
					.loadImage(_myPath[i]);
			updatePImage(myImage);
		}
		stop();
		return;
	}

	public void stop() {
		_myThread = null;
	}

	public void dispose() {
		stop();
	}

	/*
	 * hasAlpha, ConvertToBufferedImage taken from
	 * http://www.marraro.it/archives/12
	 */

	/**
	 * This method returns true if the specified image has transparent pixels
	 * 
	 * @param image
	 *            Image
	 * @return boolean
	 */
	public static boolean hasAlpha(Image image) {
		// If buffered image, the color model is readily available
		if (image instanceof BufferedImage) {
			BufferedImage bimage = (BufferedImage) image;
			return bimage.getColorModel().hasAlpha();
		}

		// Use a pixel grabber to retrieve the image's color model;
		// grabbing a single pixel is usually sufficient
		PixelGrabber pg = new PixelGrabber(image, 0, 0, 1, 1, false);
		try {
			pg.grabPixels();
		} catch (InterruptedException e) {
		}

		// Get the image's color model
		ColorModel cm = pg.getColorModel();
		return cm.hasAlpha();
	}

	/**
	 * scale a bufferedImage.
	 * 
	 * @invisible
	 * @param theImage
	 *            BufferedImage
	 * @param theWidth
	 *            float
	 * @param theHeight
	 *            float
	 * @return BufferedImage
	 */
	public static BufferedImage scaleImage(BufferedImage theImage,
			float theWidth, float theHeight) {
		AffineTransform tx = new AffineTransform();
		tx.scale(theWidth, theHeight);
		AffineTransformOp op = new AffineTransformOp(tx,
				AffineTransformOp.TYPE_BILINEAR);
		BufferedImage t = op.filter(theImage, null);
		return t;
	}

	/**
	 * convert an image of type java.awt.Image to a BufferedIamge.
	 * 
	 * @invisible
	 * @param image
	 *            Image
	 * @return BufferedImage
	 */
	public static BufferedImage ConvertToBufferedImage(Image image) {
		if (image instanceof BufferedImage) {
			return (BufferedImage) image;
		}

		// This code ensures that all the pixels in the image are loaded
		image = new ImageIcon(image).getImage();

		// Determine if the image has transparent pixels; for this method's
		// implementation, see e661 Determining If an Image Has Transparent
		// Pixels
		boolean hasAlpha = hasAlpha(image);

		// Create a buffered image with a format that's compatible with the
		// screen
		BufferedImage bimage = null;
		GraphicsEnvironment ge = GraphicsEnvironment
				.getLocalGraphicsEnvironment();
		try {
			// Determine the type of transparency of the new buffered image
			int transparency = Transparency.OPAQUE;
			if (hasAlpha) {
				transparency = Transparency.BITMASK;
			}

			// Create the buffered image
			GraphicsDevice gs = ge.getDefaultScreenDevice();
			GraphicsConfiguration gc = gs.getDefaultConfiguration();
			bimage = gc.createCompatibleImage(image.getWidth(null),
					image.getHeight(null), transparency);
		} catch (HeadlessException e) {
			// The system does not have a screen
		}

		if (bimage == null) {
			// Create a buffered image using the default color model
			int type = BufferedImage.TYPE_INT_RGB;
			if (hasAlpha) {
				type = BufferedImage.TYPE_INT_ARGB;
			}
			bimage = new BufferedImage(image.getWidth(null),
					image.getHeight(null), type);
		}

		// Copy image to buffered image
		Graphics g = bimage.createGraphics();

		// Paint the image onto the buffered image
		g.drawImage(image, 0, 0, null);
		g.dispose();

		return bimage;
	}

}
