<html>
    <head>
        <title>Result of insert a new Rating (Section 2_2_2)</title>
    </head>
    <body>
        <?php
            $SSN=      $_REQUEST["SSN"];
            $CodC=     $_REQUEST["CodC"];
            $Evaluation=    $_REQUEST["Evaluation"];
            $Date=   date('Y-m-d', strtotime($_REQUEST["Date"])); 
            
            //manca ancora il controllo su Date
            if(strlen($SSN)==0 || strlen($CodC)==0 || strlen($Date)==0){
                die("Error of type:"."Empty data");
            }
            if(strlen($SSN)>20 || filter_var($CodC, FILTER_VALIDATE_INT)==FALSE
                    || filter_var($Evaluation, FILTER_VALIDATE_INT)==FALSE
                    || $Evaluation<1 || $Evaluation>10 
                    || $Date==FALSE){
                die("Error of type:"."Integrity constraints (strlen of your values or problem with YearOfBirth)");
            }

            $con= mysqli_connect('localhost','root','', 'homework4');
            if(mysqli_connect_errno()){
                die('Error type:' . mysqli_connect_error());
            }   

            //control if the SSN is  in DB
            $sqlcontrol= "SELECT *
                          FROM USERS
                          WHERE SSN='$SSN'";
        
            $result= mysqli_query($con, $sqlcontrol);
            if(mysqli_num_rows($result)!=1){
                mysqli_close($con);
                die("Error of type:"."Integrity constraints (SSN not in my db)");
            }

            //control if the CodC is in DB
            $sqlcontrol= "SELECT *
                          FROM  CONTENT
                          WHERE CodC='$CodC'";
        
            $result= mysqli_query($con, $sqlcontrol);
            if(mysqli_num_rows($result)!=1){
                mysqli_close($con);
                die("Error of type:"."Integrity constraints (CodC not in my db)");
            }
            
            //control if the the PK(SSN,CodC,Date) is in DB
            $sqlcontrol= "SELECT *
                          FROM  RATING
                          WHERE CodC='$CodC' AND SSN='$SSN' AND Date='$Date'";
        
            $result= mysqli_query($con, $sqlcontrol);
            if(mysqli_num_rows($result)>0){
                mysqli_close($con);
                die("Error of type:"."Already exist a tuple in my db with ('$SSN', '$CodC', '$Date'");
            }

            $sql = "INSERT INTO RATING(SSN, CodC, Date, Evaluation)
                    VALUES ('$SSN', '$CodC', '$Date', '$Evaluation')";

            $result= mysqli_query($con, $sql);
            mysqli_close($con);

            echo "<h4> Inserimento nuovo rating avvenuto con successo!!!!";
        ?>
     </body>
</html>