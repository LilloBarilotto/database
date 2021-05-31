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
                die("Error of type:"."Empty data");
            }
            if(strlen($SSN)>20 ||  strlen($Name)>50 || strlen($Surname)>50 ||  filter_var($YearOfBirth, FILTER_VALIDATE_INT)==FALSE){
                die("Error of type:"."Integrity constraints (strlen of your values or problem with YearOfBirth)");
            }

            $con= mysqli_connect('localhost','root','', 'homework4');
            if(mysqli_connect_errno()){
                die('Error type:' . mysqli_connect_error());
            }   

            //control if the SSN is already in DB
            $sqlcontrol= "SELECT *
                          FROM USERS
                          WHERE SSN='$SSN'";
        
            $result= mysqli_query($con, $sqlcontrol);
            if(mysqli_num_rows($result)>0){
                mysqli_close($con);
                die("Error of type:"."Integrity constraints (SSN already in my db)");
            }
            
            $sql = "INSERT INTO USERS(SSN, Name, Surname, YearOfBirth)
                    VALUES ('$SSN', '$Name', '$Surname', $YearOfBirth)";

            $result= mysqli_query($con, $sql);
            mysqli_close($con);

            echo "<h4> Inserimento nuovo utente avvenuto con successo!!!!";

        ?>
     </body>
</html>