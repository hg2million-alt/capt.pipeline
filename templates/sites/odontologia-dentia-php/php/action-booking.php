<?php
// ARMADILHA: mail() do PHP depende de um MTA configurado no host
// (sendmail/SMTP). Não funciona de graça em runtime serverless (Vercel PHP
// incluso) sem configurar SMTP à parte. Antes de publicar: trocar este form
// por wa.me (como os outros templates da biblioteca) ou configurar SMTP.
$to = "[EMAIL DO CLIENTE]";
$subject = "New Service Appointment";

$service = $_POST['service'] ?? '';
$date    = $_POST['date'] ?? '';
$time    = $_POST['time'] ?? '';
$name    = $_POST['name'] ?? '';
$email   = $_POST['email'] ?? '';
$phone   = $_POST['phone'] ?? '';
$message = $_POST['message'] ?? '';

$email_body = '
<html>
<head>
<meta charset="UTF-8">
<title>New Appointment</title>
</head>
<body>

<h2>New Appointment Request</h2>

<table border="1" cellpadding="8" cellspacing="0">

<tr>
<th align="left">Service</th>
<td>'.htmlspecialchars($service).'</td>
</tr>

<tr>
<th align="left">Preferred Date</th>
<td>'.htmlspecialchars($date).'</td>
</tr>

<tr>
<th align="left">Preferred Time</th>
<td>'.htmlspecialchars($time).'</td>
</tr>

<tr>
<th align="left">Name</th>
<td>'.htmlspecialchars($name).'</td>
</tr>

<tr>
<th align="left">Email</th>
<td>'.htmlspecialchars($email).'</td>
</tr>

<tr>
<th align="left">Phone</th>
<td>'.htmlspecialchars($phone).'</td>
</tr>

<tr>
<th align="left">Message</th>
<td>'.nl2br(htmlspecialchars($message)).'</td>
</tr>

</table>

</body>
</html>';

$headers  = "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: text/html; charset=UTF-8\r\n";
$headers .= "From: [NOME DO CLIENTE] <" . $to . ">\r\n";
$headers .= "Reply-To: ".$name." <".$email.">\r\n";

if(mail($to, $subject, $email_body, $headers)){
    echo "sent";
}else{
    echo "failed";
}
?>