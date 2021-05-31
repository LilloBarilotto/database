<?php
    function show_query_results($result){
        $fieldinfo = mysqli_fetch_fields($result);

        foreach ($fieldinfo as $val) {
            echo "<label>$val->name: </label>"."<select name='$val->name'>";
        }

        //write the result
        while($row= mysqli_fetch_row($result)){
            foreach($row as $field){
                echo "<option value='$field'>$field</option>";
            }
        }
        echo '</select><br>';
    }

    function do_all(){
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

            $sql = "SELECT CodC
                    FROM  CONTENT";

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
                echo "<h4> No contents .-. </h4>";
            }

            mysqli_close($con);
    }

?>


<html>
    <head>
      <link href="mystyle.css" rel=stylesheet type="text/css">
    </head>
    <body>
        <h1>Insert a new user</h1>
        <form name="usersData" action="resultQuery2_2_1.php" method="POST">
            <label>Name: </label><input type="text" name="Name" size="50" value="e.g. Mario"/><br>
            <label>Surname: </label><input type="text" name="Surname" size="50" value="e.g. Rossi"/><br>
            <label>SSN: </label><input type="text" name="SSN" size="20" value="e.g. RSSMRA85T10A562S"/><br>
            <label>YearOfBirth: </label><input type="number" name="YearOfBirth" step="1" value="2000"><br>

            <input type="reset" value="Cancel"><br>
            <input type="submit" value="Send User">
        </form>

        <h1>Insert evaluation</h1>  
        <form name="RatingData" action="resultQuery2_2_2.php" method="GET">
            <?php   do_all() ?>
            <label>Date:</label><input type="date" name="Date"><br>
            <label>Evaluation: </label><input type="number" min="1" max="10" step="1" value="1" name="Evaluation"><br>
            <input type="reset" value="Cancel"><br>
            <input type="submit" value="Send User">
        </form>

     </body>
</html>