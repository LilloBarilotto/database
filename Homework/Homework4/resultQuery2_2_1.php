<html>
    <head>
        <title>Result of insert a new User (Section 2_2_1)</title>
    </head>
    <body>
        <?php
            $SSN=      $_REQUEST["SSN"];
            $Name= $_REQUEST["Name"];
            $Surname=  $_REQUEST["Surname"];
            $YearOfBirth=   $_REQUEST["YearOfBirth"];
            
            //manca ancora il controllo su YearOfBirth
            if(strlen($SSN)==0 || strlen($Name)==0 || strlen($Surname)==0  ){
                $string="Empty data";
                echo "<div style='background-color: #ff4d4d;'><h1 style='color: white;'>ERROR!!!!</h1><p style='color: white;'>ERROR TYPE:".$string."</p></div>";
                die();
            }
            if(strlen($SSN)>20 ||  strlen($Name)>50 || strlen($Surname)>50 ||  filter_var($YearOfBirth, FILTER_VALIDATE_INT)==FALSE){
                $string="Integrity constraints (strlen of your values or problem with YearOfBirth)";
                echo "<div style='background-color: #ff4d4d;'><h1 style='color: white;'>ERROR!!!!</h1><p style='color: white;'>ERROR TYPE:".$string."</p></div>";
                die();
            }

            $con= mysqli_connect('localhost','root','', 'homework4');
            if(mysqli_connect_errno()){
                $string=mysqli_connect_error();
                echo "<div style='background-color: #ff4d4d;'><h1 style='color: white;'>ERROR!!!!</h1><p style='color: white;'>ERROR TYPE:".$string."</p></div>";
                die();
            }   

            //control if the SSN is already in DB
            $sqlcontrol= "SELECT *
                          FROM USERS
                          WHERE SSN='$SSN'";
        
            $result= mysqli_query($con, $sqlcontrol);
            if(mysqli_num_rows($result)>0){
                mysqli_close($con);
                $string="Integrity constraints (SSN already in my db)";
                echo "<div style='background-color: #ff4d4d;'><h1 style='color: white;'>ERROR!!!!</h1><p style='color: white;'>ERROR TYPE:".$string."</p></div>";
                die();
            }
            
            $sql = "INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
                    VALUES ('$SSN', '$Name', '$Surname', $YearOfBirth)";

            $result= mysqli_query($con, $sql);
            mysqli_close($con);

            $string="Insertion of new user ".$SSN." was successful";
            echo "<div style='background-color: #00cc66;'><h1 style='color: white;'>Congratulations!</h1><p style='color: white;'>".$string."</p></div>";

        ?>
     </body>
</html>