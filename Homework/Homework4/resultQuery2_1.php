<?php

    function show_query_results($result){
        echo "<table border=1 cellpadding=10>";

        //write the name of column/attribute
        $array_object= mysqli_fetch_fields($result);

        echo "<tr>";
        foreach($array_object as $obj){
            echo "<th> $obj->name </th>";
        }
        echo "</tr>";

        //write the result
        while($row= mysqli_fetch_row($result)){
        
            echo "<tr>";
            foreach($row as $field){
                echo "<td> $field </td>";
            }
            echo "</tr>";
        }

        echo "</table>";

    }

?>
<html>
    <head>
        <title>Result of Section 2.1</title>
    </head>
    <body>
        <?php
            $SSN= $_REQUEST["SSN"];

            // see error pt.1 (lenght<0 or >20)
            if(strlen($SSN)==0){
                $string= "You insert an empty SSN, why? .-.";
                echo "<div style='background-color: #ff4d4d;'><h1 style='color: white;'>ERROR!!!!</h1><p style='color: white;'>ERROR TYPE:".$string."</p></div>";
                die();
            }
            if(strlen($SSN)>20){
                $string="You insert a wrong SSN with too much letters... why? .-.";
                echo "<div style='background-color: #ff4d4d;'><h1 style='color: white;'>ERROR!!!!</h1><p style='color: white;'>ERROR TYPE:".$string."</p></div>";
                die();
            }
            // end see error pt.1

            $con= mysqli_connect('localhost','root','', 'homework4');
            if(mysqli_connect_errno()){
                $string="".mysqli_connect_error();
                echo "<div style='background-color: #ff4d4d;'><h1 style='color: white;'>ERROR!!!!</h1><p style='color: white;'>ERROR TYPE:".$string."</p></div>";
                die();
            }
            
            // see error pt.2
            $result=mysqli_query($con, "SELECT SSN FROM USERS WHERE SSN='$SSN'");
            if(!$result){
                $string= mysqli_connect_error($con);
                mysqli_close($con);
                echo "<div style='background-color: #ff4d4d;'><h1 style='color: white;'>ERROR!!!!</h1><p style='color: white;'>ERROR TYPE:".$string."</p></div>";
                die();
            }

            if(mysqli_num_rows($result)==0){
                $string="You insert a non-existing SSN in my db... why? And HOW BRO COME ON!!!!";
                mysqli_close($con);
                echo "<div style='background-color: #ff4d4d;'><h1 style='color: white;'>ERROR!!!!</h1><p style='color: white;'>ERROR TYPE:".$string."</p></div>";
                die();
            }

            // end see error pt.2

            $sql = "SELECT CONTENT.CodC AS CodeOfContent, Date, Evaluation, Category
                    FROM  RATING, CONTENT 
                    WHERE RATING.SSN='$SSN'
                        AND CONTENT.CodC=RATING.CodC
                    ORDER BY Date ASC";

            $result= mysqli_query($con, $sql);

            if(!$result){
                $string= mysqli_connect_error($con);
                mysqli_close($con);
                echo "<div style='background-color: #ff4d4d;'><h1 style='color: white;'>ERROR!!!!</h1><p style='color: white;'>ERROR TYPE:".$string."</p></div>";
                die();
            }

            if(mysqli_num_rows($result)>0){
                show_query_results($result);
            }
            else{
                echo "<div style='background-color: #ff4d4d;'><h1 style='color: white;'>NOT AN ERROR BUT...</h1><p style='color: white;'>ERROR TYPE: No result... press F</p></div>";
                die();
            }

            mysqli_close($con);
        ?>
     </body>
</html>