<?php

function pdo_connect(){
    $DATABASE_HOST = 'mysql-db';
    $DATABASE_USER = 'root';
    $DATABASE_PASS = 'password';
    $DATABASE_NAME = 'badcrud';
    try {
    	return new PDO('mysql:host=' . $DATABASE_HOST . ';dbname=' . $DATABASE_NAME, $DATABASE_USER, $DATABASE_PASS);
    } catch(Exception $e) {
        return false;
    }    
}

if ( pdo_connect() ) {
    echo "connected";
} else {
    echo "failed to connect";
}
?>