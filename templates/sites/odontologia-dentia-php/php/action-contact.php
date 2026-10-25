<?php
// ARMADILHA: mail() do PHP depende de um MTA configurado no host
// (sendmail/SMTP). Não funciona de graça em runtime serverless (Vercel PHP
// incluso) sem configurar SMTP à parte. Antes de publicar: trocar este form
// por wa.me (como os outros templates da biblioteca) ou configurar SMTP.
$subject = 'New Contact Message';
$to = '[EMAIL DO CLIENTE]';

$name  = isset($_POST['name']) ? trim($_POST['name']) : '';
$email = isset($_POST['email']) ? trim($_POST['email']) : '';
$phone = isset($_POST['phone']) ? trim($_POST['phone']) : '';
$msg   = isset($_POST['message']) ? trim($_POST['message']) : '';

$message  = "Name : " . $name . "\n";
$message .= "Email : " . $email . "\n";
$message .= "Phone : " . $phone . "\n";
$message .= "Message : " . $msg . "\n";

$headers  = "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: text/plain; charset=UTF-8\r\n";
$headers .= "From: [NOME DO CLIENTE] <{$to}>\r\n";
$headers .= "Reply-To: " . $name . " <" . $email . ">\r\n";
$headers .= "Return-Path: {$to}\r\n";

if (mail($to, $subject, $message, $headers)) {
    echo 'sent';
} else {
    echo 'failed';
}
?>