<?php
/**
 * This file is part of PHPWord - A pure PHP library for reading and writing
 * word processing documents.
 *
 * PHPWord is free software distributed under the terms of the GNU Lesser
 * General Public License version 3 as published by the Free Software Foundation.
 *
 * For the full copyright and license information, please read the LICENSE
 * file that was distributed with this source code. For the full list of
 * contributors, visit https://github.com/PHPOffice/PHPWord/contributors.
 *
 * @see         https://github.com/PHPOffice/PHPWord
 * @copyright   2010-2017 PHPWord contributors
 * @license     http://www.gnu.org/licenses/lgpl.txt LGPL version 3
 */

namespace PhpOffice\PhpWord\Writer\HTML\Element;

/**
 * Table element HTML writer
 *
 * @since 0.10.0
 */
class Table extends AbstractElement
{
    /**
     * Write table
     *
     * @return string
     */
    public function write()
    {
        if (!$this->element instanceof \PhpOffice\PhpWord\Element\Table) {
            return '';
        }
		
		$content = '';
        $rows = $this->element->getRows();
        $rowCount = count($rows);
        if ($rowCount > 0) {
			$tStyle = $this->element->getStyle(); // added 
			if (is_string($tStyle) && strlen($tStyle) > 0) {
				$content .= '<table class="'.$tStyle.'">' . PHP_EOL;
			} else {
				$content .= '<table>' . PHP_EOL;
			} 
			// end table style addition

//				$content .= '<table>' . PHP_EOL; // this has been replaced by the above
	            foreach ($rows as $row) {
			/** @var $row \PhpOffice\PhpWord\Element\Row Type hint */
                $rowStyle = $row->getStyle();
                // $height = $row->getHeight();
                $tblHeader = $rowStyle->isTblHeader();
                $content .= '<tr>' . PHP_EOL;
                foreach ($row->getCells() as $cell) {
                    $writer = new Container($this->parentWriter, $cell);
                    $cellTag = $tblHeader ? 'th' : 'td';
					$cellStyle = $cell->getStyle();
					
					// border styling per cell - added by RT
					$bordertopsize = $cellStyle->getBorderTopSize();
					$borderleftsize = $cellStyle->getBorderLeftSize();
					$borderrightsize = $cellStyle->getBorderRightSize();
					$borderbottomsize = $cellStyle->getBorderBottomSize();	
					$bordertopcolor = $cellStyle->getBorderTopColor();
					$borderleftcolor = $cellStyle->getBorderLeftColor();
					$borderrightcolor = $cellStyle->getBorderRightColor();
					$borderbottomcolor = $cellStyle->getBorderBottomColor();					

					$bordersizes = array($bordertopsize, $borderleftsize, $borderrightsize, $borderbottomsize);
					$bordercolors = array($bordertopcolor, $borderleftcolor, $borderrightcolor, $borderbottomcolor);
					
					if (strlen($bordertopcolor) > 0 && count(array_unique($bordersizes)) === 1 && count(array_unique($bordercolors)) === 1) {
						$inlineCSS = 'border: '.$bordertopsize.'px solid #'. $bordertopcolor;
					}
					
                    if (!empty($inlineCSS)) {
						$content .= "<{$cellTag} style='".$inlineCSS."'>" . PHP_EOL;
					} else {
						$content .= "<{$cellTag}>" . PHP_EOL;
					}
					// end of inline border styling for table cells - RT
					
                    $content .= $writer->write();
                    $content .= "</{$cellTag}>" . PHP_EOL;
                }
                $content .= '</tr>' . PHP_EOL;
            }
            $content .= '</table>' . PHP_EOL;
        }

        return $content;
    }
	
}
