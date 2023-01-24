$texto = "c:\Forex\FPM\MQL4\Experts\gbpjpy buy m15 pfol 1.mq4(353,4) : error 152: 'sqManageOrders' - some operator expected"
$texto = "c:\Forex\FPM\MQL4\Experts\gbpjpy buy m15 pfol 1.mq4(353,4)"

#$meuarr = "Teste " + $texto.Substring($texto.IndexOf('(') + 1, $texto.Length - $texto.IndexOf(')'))
#$linha = $texto.Substring($texto.IndexOf('(') + 1);
#$coluna = $linha.Substring($texto.IndexOf(','));
#$meuarr = $texto.Split('\D')

$meuarr = $texto -Split {$_ -eq "(" -or $_ -eq ")" -or $_ -eq ","}

#(Split-Path $Filename -Leaf).ToString()

$meuarr[1] + ":" + $meuarr[2]