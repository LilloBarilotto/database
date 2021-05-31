<?php
    function show_query_results($result){

        echo '<select name="SSN">';
        //write the result
        while($row= mysqli_fetch_row($result)){
            foreach($row as $field){
                echo "<option value='$field'>$field</option>";
            }
        }
        echo '</select>';
    }
?>


<html>
    <head>
      <link href="mystyle.css" rel=stylesheet type="text/css">
    </head>
    <body>
        <h1>Search Rating by a user</h1>
        <form name="usersData" action="resultQuery2_1.php" method="GET">
        <label>Choose a user:</label>
          <?php
            $con= mysqli_connect('localhost','root','', 'homework4');
            if(mysqli_connect_errno()){
                die("".mysqli_connect_error());
            }

            $sql = "SELECT SSN
                    FROM  USERS";

            $result= mysqli_query($con, $sql);

            if(!$result){
                $error= mysqli_connect_error($con);
                mysqli_close($con);
                die("Query error: ".$error);
            }

            if(mysqli_num_rows($result)>0){
                show_query_results($result);
            }
            else{
                echo "<h4> No users .-. </h4>";
            }

            mysqli_close($con);
          ?>
          <input type="submit" value="Send User">
        </form>
        
     </body>
</html>