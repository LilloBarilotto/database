Given the following relational tables

TEACHER (TeacherID, FirstName, LastName, Department)
COURSE (CourseID, CourseName, Year, Semester, MainTeacherID, Language)
STUDENT (StudentID, FirstName, LastName, BirthDate, Nationality)
STUDENT-COURSE-ENROLLMENT (CourseID, StudentID, EnrollmentYear)
STREAMING-VIDEOLECTURE (VideoLectureID, CourseID, Topic, Date,  DurationInMinutes,  TeacherID)
STREAMING-VIDEOLECTURE-ATTENDANCE (StudentID, VideoLectureID, CourseID, AttendanceInMinutes)
Write the following query in SQL language:

Select the student ID, first name, last name, and nationality of each student who has never attended a streaming video-lecture longer than 10% of the video-lecture duration.


SELECT StudentID, FirstName, LastName, Nationality
FROM STUDENT
WHERE StudentID NOT IN 
            (
                SELECT StudentID
                FROM STREAMING-VIDEOLECTURE SV, STREAMING-VIDEOLECTURE-ATTENDANCE SVA
                WHERE SV.VideoLectureID=SVA.VideoLectureID
                            AND SVA.AttendanceInMinutes>0.1*SV.DurationInMinutes
             )
             
            
Given the following relational tables

TEACHER (TeacherID, FirstName, LastName, Department)
COURSE (CourseID, CourseName, Year, Semester, TeacherID, Language)
STUDENT (StudentID, FirstName, LastName, BirthDate, Nationality)
STUDENT-COURSE-ENROLLMENT (CourseID, StudentID, EnrollmentYear)
STREAMING-VIDEOLECTURE (VideoLectureID,  CourseID, Topic, Date,  DurationInMinutes,  TeacherID)
STREAMING-VIDEOLECTURE-ATTENDANCE (StudentID, VideoLectureID,  CourseID, AttendanceInMinutes)
Write the following query in SQL language:

For each teacher of the Department of "Control and Computer Engineering" who teaches at least three courses, select the teacher’s first and last name, and the total number of the teacher’s streaming video-lectures.

SELECT FirstName, LastName, COUNT(*) As VideoLecture#
FROM TEACHER T, STREAMING-VIDEOLECTURE SV
WHERE T.TeacherID=SV.TeacherID
            AND T.TeacherID IN 
                        ( SELECT TeacherID
                            FROM COURSE
                            GROUP BY TeacherID
                             HAVING COUNT(*)>=3)
GROUP BY FirstName, LastName, T.TeacherID





Given the following relational tables

TEACHER (TeacherID, FirstName, LastName, Department)
COURSE (CourseID, CourseName, Year, Semester, TeacherID, Language)
STUDENT (StudentID, FirstName, LastName, BirthDate, Nationality)
STUDENT-COURSE-ENROLLMENT (CourseID, StudentID, EnrollmentYear)
STREAMING-VIDEOLECTURE (VideoLectureID, CourseID, Topic, Date, DurationInMinutes, TeacherID)
STREAMING-VIDEOLECTURE-ATTENDANCE (StudentID, VideoLectureID, CourseID, AttendanceInMinutes)
Write the following query in SQL language:

For each student enrolled in at least 3 courses in the 2019-2020 enrollment year, select the student ID and last name, and the ID of each course for which the student attended all streaming video-lectures of that course.




SELECT StudentID, LastName, CourseID
FROM STUDENT S, STREAMING-VIDEOLECTURE-ATTENDANCE SVA
WHERE S.StudentID = SVA.StudentID
        AND S.StudentID IN 
                               (SELECT StudentID
                                STUDENT-COURSE-ENROLLMENT SCE
                                WHERE EnrollemntYear="2019-2020"
                                GROUP BY StudentID
                                HAVING COUNT(*)>=3)
 GROUP BY S.StudentID, S.LastName, SVA.CourseID
 HAVING COUNT(*)= (SELECT COUNT(*)
                                     FROM STREAMING-VIDEOLECTURE SV
                                     WHERE SV.CourseID  = SVA.CourseID)
