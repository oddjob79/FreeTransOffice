<?php

require_once '../bin/bootstrap.php';

class Reports {
	
	public function defaultInvoice($invheader, &$invdetails) {
		$version = 59;

		// Creating the new document...
		$phpWord = new \PhpOffice\PhpWord\PhpWord();

		// New section
		$section = $phpWord->addSection();

		// Define styles
			// Fonts
			$largeBoldBlackFont = 'LgBoldBlack';
			$phpWord->addFontStyle($largeBoldBlackFont, array('name' => 'Times New Roman', 'size' => 20, 'color' => '000000', 'bold' => true));
			$regularLetterFont = 'regLetter';
			$phpWord->addFontStyle($regularLetterFont, array('name' => 'Times New Roman', 'size' => 12, 'color' => '000000', 'bold' => false));

			// Paragraphs / Styles
			$titleStyle = 'title';
			$phpWord->addParagraphStyle($titleStyle, array('alignment' => \PhpOffice\PhpWord\SimpleType\Jc::CENTER, 'spaceAfter' => 750));
			$rJustAlign = 'rJustAlign';
			$phpWord->addParagraphStyle($rJustAlign, array('alignment' => \PhpOffice\PhpWord\SimpleType\Jc::END));
			$lJustAlign = 'lJustAlign';
			$phpWord->addParagraphStyle($lJustAlign, array('alignment' => \PhpOffice\PhpWord\SimpleType\Jc::START));
		// End Define Styles

		// Set certain fields to variables

			// user / company name
			$contactname = (empty($invheader['user_company_name'])) ? $invheader['user_fullname'] : $invheader['user_company_name'];
		
			// set format of invoice date
			switch ($invheader['date_format']) {
				case 1:
					$invoicedate = DateTime::createFromFormat('Y-m-d H:i:s', $invheader['invoice_date'])->format('d/m/Y');
					break;
				case 2:
					$invoicedate = DateTime::createFromFormat('Y-m-d H:i:s', $invheader['invoice_date'])->format('m/d/Y');
					break;
				case 3:
					$invoicedate = DateTime::createFromFormat('Y-m-d H:i:s', $invheader['invoice_date'])->format('d F Y');
					break;
			}		
		
			// invoice number & invoice total strings
			$invnumtext = $invheader['invoice_number_label'].': '.$invheader['invoice_number'];
			$invtotaltext = $invheader['invoice_total_label'].': '.number_format($invheader['invoice_total'], 2, '.', ',').' '.$invheader['client_currency_code'];			
			
			// section a fields
			$sectiona_field1 = (empty($invheader['section_a_field_label_1'])) ? $invheader['section_a_field_1'] : $invheader['section_a_field_label_1'] . ': ' . $invheader['section_a_field_1'];
			$sectiona_field2 = (empty($invheader['section_a_field_label_2'])) ? $invheader['section_a_field_2'] : $invheader['section_a_field_label_2'] . ': ' . $invheader['section_a_field_2'];
			$sectiona_field3 = (empty($invheader['section_a_field_label_3'])) ? $invheader['section_a_field_3'] : $invheader['section_a_field_label_3'] . ': ' . $invheader['section_a_field_3'];
			
			// section b fields
			$sectionb_field1 = (empty($invheader['section_b_field_label_1'])) ? $invheader['section_b_field_1'] : $invheader['section_b_field_label_1'] . ': ' . $invheader['section_b_field_1'];
			$sectionb_field2 = (empty($invheader['section_b_field_label_2'])) ? $invheader['section_b_field_2'] : $invheader['section_b_field_label_2'] . ': ' . $invheader['section_b_field_2'];
			$sectionb_field3 = (empty($invheader['section_b_field_label_3'])) ? $invheader['section_b_field_3'] : $invheader['section_b_field_label_3'] . ': ' . $invheader['section_b_field_3'];
			
			// Table
			
			// set column width by number of columns set in report config
			$numcolumns = (empty($invheader['num_columns'])) ? 1 : $invheader['num_columns'];
			$colwidth = 9000 / $numcolumns;
			if ($numcolumns > 6) { $tablefontsize = 8; } else $tablefontsize = 10;
			
			$tableStyleName = 'JobTable';
			$phpWord->addTableStyle($tableStyleName, array('borderColor' => 'FFFFFF', 'borderSize' => 0, 'width' => 100));			
			$tableHeadStyle = 'TableHeaderStyle';
			$phpWord->addFontStyle($tableHeadStyle, array('name' => 'Times New Roman', 'size' => $tablefontsize, 'color' => '000000', 'bold' => true));
			$tableBodyStyle = 'TableBodyStyle';
			$phpWord->addFontStyle($tableBodyStyle, array('name' => 'Times New Roman', 'size' => $tablefontsize, 'color' => '000000', 'bold' => false));
			$tableCellStyle = array('borderColor' => 'FFFFFF', 'borderSize' => 0);
			
// invoice title
		$section->addText('Invoice '.$version, $largeBoldBlackFont, $titleStyle);

// user name & address		
		$section->addText($contactname, $regularLetterFont, $rJustAlign);
		$section->addText($invheader['user_address_1'], $regularLetterFont, $rJustAlign);
		if (!empty($invheader['user_address_2'])) {
			$section->addText($invheader['user_address_2'], $regularLetterFont, $rJustAlign);
		}
		$section->addText($invheader['user_city'], $regularLetterFont, $rJustAlign);
		$section->addText($invheader['user_postalcode'].', '.$invheader['user_country'], $regularLetterFont, $rJustAlign);
		$section->addText($invheader['user_email'], $regularLetterFont, $rJustAlign);
	//	ADD PHONE NUMBER & MAYBE CLIENT VENDOR CODE

// client name & address
		if (!empty($invheader['invoice_to_fullname'])) {
			$section->addText($invheader['invoice_to_fullname'], $regularLetterFont, $lJustAlign);
		}
		$section->addText($invheader['client_name'], $regularLetterFont, $lJustAlign);		
		$section->addText($invheader['client_address_1'], $regularLetterFont, $lJustAlign);
		if (!empty($invheader['client_address_2'])) {
			$section->addText($invheader['client_address_2'], $regularLetterFont, $lJustAlign);
		}
		$section->addText($invheader['client_city'], $regularLetterFont, $lJustAlign);
		$section->addText($invheader['client_postalcode'].', '.$invheader['client_country'], $regularLetterFont, $lJustAlign);

// invoice date, greeting & opening text
		$section->addText($invoicedate, $regularLetterFont, $rJustAlign);
		$section->addText($invheader['greeting_text'].',', $regularLetterFont, $lJustAlign);
		$section->addTextBreak(1);
		$section->addText($invheader['opening_text'], $regularLetterFont, $lJustAlign);		
		$section->addTextBreak(1);

// inv number		
		$section->addText($invnumtext, $regularLetterFont, $lJustAlign);				
		$section->addTextBreak(1);

	// word doc requires a field width
	
		$jobtable = $section->addTable($tableStyleName);
			$jobtable->addRow();
//				$jobtable->addCell(null, $tableCellStyle)->addText($invheader['col_a_label'], $tableHeadStyle);
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($invheader['col_a_label'], $tableHeadStyle);
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($invheader['col_b_label'], $tableHeadStyle);
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($invheader['col_c_label'], $tableHeadStyle);
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($invheader['col_d_label'], $tableHeadStyle);
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($invheader['col_e_label'], $tableHeadStyle);
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($invheader['col_f_label'], $tableHeadStyle);
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($invheader['col_g_label'], $tableHeadStyle);
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($invheader['col_h_label'], $tableHeadStyle);
		
		foreach ($invdetails as $jobdetails) {
			$jobtable->addRow();
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($jobdetails['col_a_field'], $tableBodyStyle);
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($jobdetails['col_b_field'], $tableBodyStyle);
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($jobdetails['col_c_field'], $tableBodyStyle);				
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($jobdetails['col_d_field'], $tableBodyStyle);				
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($jobdetails['col_e_field'], $tableBodyStyle);				
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($jobdetails['col_f_field'], $tableBodyStyle);				
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($jobdetails['col_g_field'], $tableBodyStyle);				
				$jobtable->addCell($colwidth, $tableCellStyle)->addText($jobdetails['col_h_field'], $tableBodyStyle);				
		}

		
// invoice total		
		$section->addTextBreak(1);
		$section->addText($invtotaltext, $regularLetterFont, $rJustAlign);						

// inv header section a		
		if (!empty($invheader['section_a_label'].$sectiona_field1.$sectiona_field2.$sectiona_field3)) {
			$section->addTextBreak(1);
		}
		if (!empty($invheader['section_a_label'])) {
			$section->addText($invheader['section_a_label'], $regularLetterFont, $lJustAlign);
		}
		if (!empty($sectiona_field1)) { $section->addText($sectiona_field1, $regularLetterFont, $lJustAlign); }
		if (!empty($sectiona_field2)) { $section->addText($sectiona_field2, $regularLetterFont, $lJustAlign); }
		if (!empty($sectiona_field3)) { $section->addText($sectiona_field3, $regularLetterFont, $lJustAlign); }

// inv header section b
		if (!empty($invheader['section_b_label'].$sectionb_field1.$sectionb_field2.$sectionb_field3)) {
			$section->addTextBreak(1);
		}	
		if (!empty($invheader['section_b_label'])) {
			$section->addText($invheader['section_b_label'], $regularLetterFont, $lJustAlign);
		}
		if (!empty($sectionb_field1)) { $section->addText($sectionb_field1, $regularLetterFont, $lJustAlign); }
		if (!empty($sectionb_field2)) { $section->addText($sectionb_field2, $regularLetterFont, $lJustAlign); }
		if (!empty($sectionb_field3)) { $section->addText($sectionb_field3, $regularLetterFont, $lJustAlign); }

// closing text
		$section->addTextBreak(2);
		$section->addText($invheader['closing_text'], $regularLetterFont, $lJustAlign);
		$section->addTextBreak(1);
		$section->addText($invheader['user_fullname'], $regularLetterFont, $lJustAlign);
		if (!empty($invheader['user_company_name'])) {
			$section->addText($invheader['user_company_name'], $regularLetterFont, $lJustAlign);
		}
		
		// Saving the document as OOXML file...
		$reportpath = '/opt/bitnami/apache2/htdocs/transoffice/dev/reports/';
		$file = 'invoice_'.$version;
		

		// below will create a word doc
		
		$objWriter = \PhpOffice\PhpWord\IOFactory::createWriter($phpWord, 'Word2007');
		$filedoc = $file.'.docx';
		$objWriter->save($filedoc);

		/*
		// code below makes file available for download
		header('Content-Description: File Transfer');
		header('Content-Type: application/octet-stream');
		header('Content-Disposition: attachment; filename='.$filedoc);
		header('Content-Transfer-Encoding: binary');
		header('Expires: 0');
		header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
		header('Pragma: public');
		header('Content-Length: ' . filesize($filedoc));
		flush();
		readfile($filedoc);
		//unlink($filename); // deletes the temporary file (does not delete temp file, deletes permanent file on server)
		//exit;
		*/

		// Below will output a pdf
		// Saving the document as HTML file...
		$objWriter = \PhpOffice\PhpWord\IOFactory::createWriter($phpWord, 'HTML');
		$filehtml = $file.".html";
		$objWriter->save($reportpath.$filehtml);

		$htmlfilepath = file_get_contents($reportpath.$filehtml);

		// instantiate and use the dompdf class
		$dompdf = new \Dompdf\Dompdf();
		$dompdf->loadHtml($htmlfilepath);

		// (Optional) Setup the paper size and orientation
		$dompdf->setPaper('letter', 'portrait');

/*		
		// Render the HTML as PDF
		$dompdf->render();
		$filepdf = $file.".pdf";
		$file_to_save = $reportpath.$filepdf;
*/
		
		// debug 
		/*
			$f;
			$l;
			if(headers_sent($f,$l))
			{
				echo $f,'<br/>',$l,'<br/>';
				die('now detect line');
			}		
			*/
		// end debug

/*		
		file_put_contents($file_to_save, $dompdf->output());
		
		ob_end_clean();
		// Output the generated PDF to Browser
//		 $dompdf->stream();

		$dompdf->stream($file_to_save, array("Attachment" => true));
*/
		
		/* Note: we skip RTF, because it's not XML-based and requires a different example. */
		/* Note: we skip PDF, because "HTML-to-PDF" approach is used to create PDF documents. */
		
	}
}		