<?php
// TESTING BY RT

namespace PhpOffice\PhpWord\Writer\HTML\Style;

//use PhpOffice\PhpWord\SimpleType\Jc;
use PhpOffice\PhpWord\Style\Table as TableStyle;

/**
 * Paragraph style HTML writer
 *
 * @since 0.10.0
 */
class Table extends AbstractStyle
{
    /**
     * Write style
     *
     * @return string
     */
    public function write()
    {
        $style = $this->getStyle();
        if (!$style instanceof TableStyle) {
            return array('empty');
        } 
        $css = array();

		// borders
		$bordertopsize = $style->getBorderTopSize();
		$borderleftsize = $style->getBorderLeftSize();
		$borderrightsize = $style->getBorderRightSize();
		$borderbottomsize = $style->getBorderBottomSize();
		$borderinsidehsize = $style->getBorderInsideHSize();
		$borderinsidevsize = $style->getBorderInsideVSize();

		$bordertopcolor = $style->getBorderTopColor();
		$borderleftcolor = $style->getBorderLeftColor();
		$borderrightcolor = $style->getBorderRightColor();
		$borderbottomcolor = $style->getBorderBottomColor();
		$borderinsidehcolor = $style->getBorderInsideHColor();
		$borderinsidevcolor = $style->getBorderInsideVColor();

		$bordersizes = array($bordertopsize, $borderleftsize, $borderrightsize, $borderbottomsize, $borderinsidehsize, $borderinsidevsize);
		$bordercolors = array($bordertopcolor, $borderleftcolor, $borderrightcolor, $borderbottomcolor, $borderinsidehcolor, $borderinsidevcolor);
		
		if (count(array_unique($bordersizes)) === 1 && count(array_unique($bordercolors)) === 1) {
			$css['border'] = $bordertopsize.'px solid #'. $bordertopcolor;
		}
		
		return $this->assembleCss($css);
		

    }
}
