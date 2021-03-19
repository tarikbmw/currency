<?php
/**
 * Data source
 */
const CURRENCY_SRC     = 'http://www.cbr.ru/scripts/XML_daily.asp';

/**
 * XSLT Template
 */
const TEMPLATE         = '/template/main.xsl';

/**
 * Create processing instruction in XML document
 * @param DOMDocument   $target target XML document
 * @param string        $url    xsl url
 */
function setStylesheet(DOMDocument $target, string $url)
{
    $hdr    = sprintf('type="text/xsl" href="%s"', $url);
    $pi     = $target->createProcessingInstruction('xml-stylesheet', $hdr);

    if ($target->documentElement instanceof \DOMNode)
    {
        $target->insertBefore($pi, $target->documentElement);
        return;
    }

    $target->appendChild($pi);
}

/**
 * Load XML data to cache file
 * @param string $source    data source URL
 * @param string $cacheName cache file name to save XML data
 * @return string
 * @throws Exception
 */
function loadXMLData(string $source, string $cacheName):string
{
    $loader = file_get_contents($source);
    if (!$loader)
        throw new Exception('Unable to load XML source.');

    $data = iconv('cp1251', 'utf8', $loader);
    if (!$data)
        throw new Exception('Unable to encode XML source.');

    $data = str_replace(['windows-1251', ','], ['utf-8', '.'], $data);

    $xml = new DOMDocument('1.0', 'utf-8');
    if (!$xml->loadXML($data))
        throw new Exception('Unable to create DOMDocument from XML source.');

    setStylesheet($xml, TEMPLATE);

    if (!$xml->save($cacheName))
        throw new Exception('Unable to save XML file in cache.');

    return  $xml->saveXML();
}

/**
 * Cache file name for today
 * TODO: Add previous days cache check if today load failed
 */
$cacheName = sprintf('data/%s.xml', (new \DateTime())->format('dmY'));
try
{
    $output = NULL;

    if (file_exists($cacheName))
        $output = file_get_contents($cacheName);

    if (!$output)
        $output = loadXMLData(CURRENCY_SRC, $cacheName);

    header('Content-type: text/xml');
    header('Character-encoding: utf8');
    echo $output;
}
catch (Exception $error)
{
    header('Content-type: text/html');
    echo $error->getMessage();
}
