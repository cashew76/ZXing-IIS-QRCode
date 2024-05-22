' ASPX Code, Used on IIS, copied zxing.dll/zxing.pdb/zxing.XML into your iis application bin folder. Usage: http://localhost/QRDotNet.aspx?BARCODETEXT

<%@ Page language="vb" debug=true %> <%@ Import NameSpace = "System.Drawing" %> <%
' Used for Crystal Reports Image QR Code trick
' https://blogs.sap.com/2013/05/31/qr-codes-in-crystal-reports/
' Similar to https://zxing.org/w/chart?cht=qr&chs=120x120&chld=L&choe=UTF-8&chl=QRCODETEXT
'

'-----------------------------------------------'
'QR-Code
'-----------------------------------------------'

Dim hash = Page.Request.QueryString.ToString()
hash = Regex.Replace(hash, "(?<=^.{17})\+", "")
hash = Regex.Replace(hash, "%24", "$")
hash = Regex.Replace(hash, "%25", "%")
hash = Regex.Replace(hash, "%2f", "/")
hash = Regex.Replace(hash, "%22", """")
hash = Regex.Replace(hash, "%20", " ")
hash = Regex.Replace(hash, "\+", " ")

' Thanks to: http://www.timstall.com/2005/03/understanding-httprequest-urls_16.html

Response.ContentType = "image/png"
Response.Clear()

Dim ZX As New ZXing.BarcodeWriter
Dim bmp As Bitmap
Dim options as ZXing.QrCode.QrCodeEncodingOptions

options = New ZXing.QrCode.QrCodeEncodingOptions
options.ErrorCorrection = ZXing.QrCode.Internal.ErrorCorrectionLevel.M
options.Height = 50
options.Width = 50
options.Margin = 0
options.PureBarcode = True

Zx.Format = ZXing.BarcodeFormat.QR_CODE
Zx.Options = options

bmp = Zx.Write(hash)
'bmp.Save("C:\temp\QRCODE\qrcode.png", Imaging.ImageFormat.Png)

Response.BufferOutput = true
bmp.Save(HttpContext.Current.Response.OutputStream, Imaging.ImageFormat.Png)
Response.OutputStream.Flush()
Response.End()

'-----------------------------------------------'
%>