# Lecture-1

### 1. Definition of Data Compression: Compression is a process of deriving more compact (i.e., smaller) representations of data.

<img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026092523839.png" alt="image-20221026092523839" style="zoom:80%;" />

----------------------------

### 2. Two broad types of data compression:
   * Lossless Compression

     * It is the kind of compression where the original data can be fully and 100% accurately reconstructed (recovered) from the compressed data.

     * Needed for certain applications where full recovery of data is essential: **Text Compression** And **Database records compression (e.g., bank records, student records, tax records)**.
   * Lossy Compression
     * It is the kind of compression where the original data can never be fully recovered from the compressed data with 100% fidelity
       * Needed in applications where the original data size is too large and needs to be compressed to much smaller sizes than lossless compression can achieve: **Image, video and audio compression**.

----------------------------------------------

### 3. Two broad strategies for data compression

* Reducing the redundancy present in the data itself
* Exploiting the characteristics (and limitations) of the human senses/faculties
  * Human Vision
  * Human Hearing
  * Actually all the 5 senses of humans have limitations, but digital data pertains only to the audio-visual senses (so far) 

---------------------------------------------

### 4. Some terms of Compression

 * To compress: to carry out the process of compression

 * To decompress: to reconstruct the original data from the compressed representation

    * Synonyms of “compress”:
      * code ≡ compress ≡ encode
      * (en)coding ≡ 𝐜𝐜ompression
      * (en)coder ≡ compression algorithm

    * Synonyms of “decompress”:
      * Decode ≡ decompress ≡ reconstruct
      * Decoding ≡ Decompression ≡ Reconstruction
      * Decoder ≡ decompression algorithm


 * Coded Bitstream: The binary string representing the whole coded (compressed) data

 * Codeword: A binary string representing either the whole coded bitstream or one coded data symbol (you will tell the difference from the context)<img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026094741881.png" alt="image-20221026094741881" style="zoom:80%;" />

-------------------

### 5. Compression Performance Metrics:

   * *Size Reduction Measures*:

      * Bit Rate  (**bitrate** or **BR**): Average number of bits per original data element, after compression. (**Smaller is better.**)

        <img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026095200629.png" alt="image-20221026095200629" style="zoom: 80%;" />

      * Compression Ratio: (**Bigger is better.**)

        ​	<img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026095403207.png" alt="image-20221026095403207" style="zoom:67%;" />

   * *Quality Measures*:

      * SNR:

        * Let $I$ be an original signal (e.g., an image), and $\hat I$ be its lossily reconstructed counterpart

        * Signal-to-Noise Ratio (SNR) in the case of lossy compression: it is the **fidelity** of the decoded data w.r.t. the original.

          ​	<img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026100307197.png" alt="image-20221026100307197" style="zoom:80%;" />

          where for any vector/matrix/set of number $I = \{x_1, x_2, x_3,...x_N\}$, $\Vert I \Vert^2 = x_1^2 + x_2^2 + ... + x_N^2$

        * The unit of SNR is "decibel" (or **dB** for short)

        * Does it make sense to compute SNR for lossless compression? 

      * MEAN-SQUARE ERROR(**MSE**, **RMSE**)

        ​	<img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026101015241.png" alt="image-20221026101015241" style="zoom: 80%;" />

        ​	<img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026101049015.png" alt="image-20221026101049015" style="zoom: 80%;" />

        **Therefore, $SNR = -10log_{10}RMSE$**

        **Observations:** 

        * The smaller the RMSE (or the MSE), the higher the SNR 
        * Therefore, the higher the SNR, the better the quality of the reconstructed data

	-----------------------------------------
	
	### 6. Basic Image / Video / Sound Definition:
	
	see the power point of Lecture-1.
	
	----------------------
	
	### 7. Strategies for Compression
	
	1. Redundancy Reduction
	
	   * Symbol-Level Representation Redundancy 
	
	     <img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026102723548.png" alt="image-20221026102723548" style="zoom:80%;" />
	
	   * Block-Level Representation Redundancy
	
	     <img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026102802610.png" alt="image-20221026102802610" style="zoom:80%;" />
	
	   * Inter-Pixel Spatial Redundancy
	
	     <img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026102846024.png" alt="image-20221026102846024" style="zoom:80%;" />
	
	   * Inter-Pixel Temporal Redundancy (in Video) 
	
	     <img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026102906540.png" alt="image-20221026102906540" style="zoom:80%;" />
	
	   * Audio-visual Redundancy: limitations of the human senses
	
	     The human visual system (HVS) has certain limitations that make many image contents invisible.
	
	     Those contents, termed visually redundant, are the target of removal in lossy compression.
	
	     That is, if you clutter too many details within a small spatial region, we stop being able to see contrasts and details.
	
	     we can see the details on the Page28-35 of Lecture-1's PPT.

---------------------------------------------------------------------

### 8. Information Theory

It deals with

* Measuring information (in bits) 
* Coding information efficiently (e.g., lossless compression) 
* Error-correcting coding to tolerate error and noise in communication channels

​	<img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026110020432.png" alt="image-20221026110020432" style="zoom: 50%;" />

#### Information can be viewed as uncertainty: the more uncertain something is, the more information there is in a sentence about its occurrence.

​	<img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026110125166.png" alt="image-20221026110125166" style="zoom: 50%;" />



​	<img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026110309781.png" alt="image-20221026110309781" style="zoom: 50%;" />



​	<img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026110429133.png" alt="image-20221026110429133" style="zoom:50%;" />



​	<img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026110459707.png" alt="image-20221026110459707" style="zoom:50%;" />



​	<img src="https://raw.githubusercontent.com/WillSilent/myPic/master/img/image-20221026110526179.png" alt="image-20221026110526179" style="zoom:50%;" />

