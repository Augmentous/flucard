<?php

$image = exif_thumbnail($_SERVER['argv'][1], $width, $height, $type);

if ($image!==false) {
	$exif_ifd0 = read_exif_data($_SERVER['argv'][1], 'IFD0' , 0);
	$array1 = explode(" ", $exif_ifd0['DateTime']);
	$array2 = explode(":",$array1[0]);
	$array3 = explode(":",$array1[1]);
	$newname = "$array2[0]-$array2[1]-$array2[2]/$array2[0]:$array2[1]:$array2[2].$array3[0]:$array3[1]:$array3[2].JPG";
	$handle = fopen ("/mnt/sd/DCIM_t/$newname, 'a');
	fwrite($handle, $image);
	fclose($handle);
   exit;
} else {
  echo 'No thumbnail available';
}
?>