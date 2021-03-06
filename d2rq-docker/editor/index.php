<?php
  unset($_SESSION["message_output"]);
  unset($_SESSION["mapping_text"]);

  if(isset($_POST['runFunction']) && function_exists($_POST['runFunction'])) {
  	call_user_func($_POST['runFunction']);
  }

  function map () {
    $dbName = $_POST["db_name"];

    if (empty($dbName))
      $dbName = "default";

  	$message = shell_exec("/var/www/scripts/map.sh $dbName");
  	$_SESSION["message_output"] = $message;
    $_SESSION["mapping_text"] = shell_exec("/var/www/scripts/echo_mapping.sh");
  }

  function dump () {
    $baseruri = $_POST["baseruri"];
    if ( empty($baseruri) ) {
      $message = shell_exec("/var/www/scripts/dump.sh");
    } else {
      $message = shell_exec("/var/www/scripts/dump.sh $baseruri");
    }
    $message = shell_exec("/var/www/scripts/dump.sh $baseruri");
  	$_SESSION["message_output"] = $message;
  }

  function save () {

    $_SESSION["mapping_text"] = $_POST["mapping_file"];
    $mappingFile =  escapeshellarg($_POST["mapping_file"]);

    $message = shell_exec("/var/www/scripts/save.sh $mappingFile");
    $_SESSION["message_output"] = $message;
  }
  ?>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Map SQL to RDF</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.css">
  </head>
  <body>
    <h1>Edit Mapping File</h1>

    <form action="index.php" method="post" id="save_form">

    <div class="row">
      <div class="col-md-offset-3 col-md-6 col-md-offset-3">
        <div class="row">
          <div class="text-info" id="message_output"><?php print_r($_SESSION["message_output"]); ?></div>
        </div>
        <br/>
        <div class="row">
          <div class="btn-group" role="group" aria-label="...">
            <button type="submit" class="btn btn-default" name="runFunction" value="map">Create Mapping</button>
            <span class="btn btn-default btn-file">
            Load Mapping File <input type="file" id="fileinput"/>
            </span>
            <button type="submit" class="btn btn-default" name="runFunction" value="dump">Create Dump</button>
          </div>
        </div>
      </div>
    </div>
    <br />
    <div class="row">
      <br/>
      <input type="text" id="db_name" name="db_name" class="col-md-offset-3 col-md-6 col-md-offset-3" placeholder="Enter database name" value="<?php if (isset($_POST['db_name'])) echo $_POST['db_name']; ?>">
      <br/><br/>
      <input type="text" id="baseuri" name="baseruri" class="col-md-offset-3 col-md-6 col-md-offset-3" placeholder="Enter a base URI" value="<?php if (isset($_POST['baseruri'])) echo $_POST['baseruri']; ?>"><br /><br/>
      <br/>
      <textarea name="mapping_file" form="save_form" class="col-md-offset-1 col-md-10 col-md-offset-1" id="textarea"><?php
        if (isset($_POST["mapping_file"]))
          echo $_POST["mapping_file"]
        ?></textarea>
    </div>
    <br />
    <div class="row">
      <div class="col-md-offset-3 col-md-6 col-md-offset-3">
        <div class="btn-group" role="group" aria-label="...">
          <button id ="save_button" type="submit" form="save_form" class="btn btn-default" name="runFunction" value="save">Save Mapping File</button>
        </div>
      </div>
    </div>

    </form>
    <script type='text/javascript' src="./js/behave.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script>
      window.onload = function(){

        var editor = new Behave({

          textarea: 		document.getElementById('textarea'),
          replaceTab: 	true,
          softTabs: 		true,
          tabSize: 		4,
          autoOpen: 		true,
          overwrite: 		true,
          autoStrip: 		true,
          autoIndent: 	true
        });

      };

        // Check for the various File API support.
        if (window.File && window.FileReader && window.FileList && window.Blob) {

        function readSingleFile(evt) {
          //Retrieve the first (and only!) File from the FileList object
          var f = evt.target.files[0];

          if (f) {
            var r = new FileReader();
            r.onload = function(e) {
             var contents = e.target.result;
              // alert( "Got the file.n"
              //       +"name: " + f.name + "n"
              //       +"type: " + f.type + "n"
              //       +"size: " + f.size + " bytesn"
              //       + "starts with: " + contents.substr(1, contents.indexOf("n"))
              // );
      		document.getElementById("textarea").value = contents;
            }
            r.readAsText(f);
          } else {
            alert("Failed to load file");
          }
        }

        document.getElementById('fileinput').addEventListener('change', readSingleFile, false);

        } else {
          alert('The File APIs are not fully supported by your browser.');
        }
    </script>
  </body>
</html>
