function Student(fname, lname) {
  this.name =  fname + ' ' + lname;
  this.courses = [];
}

Student.prototype.enroll = function(course) {
  if(this.courses.indexOf(course) === -1) {
    this.courses.push(course);
    course.students.push(this);
  } else {
    throw "Already enrolled!"
  }
}

Student.prototype.course_load = function() {
  load = {}

  function pushToLoad(element, index, array) {
    if(!isNaN(load[element.department])) {
      load[element.department] += element.numberCredits;
    } else {
      load[element.department] = element.numberCredits
    }
  }
  this.courses.forEach(pushToLoad)

  return load;
}

function Course(name, department, numberCredits, days, timeBlock) {
  this.name = name;
  this.department = department;
  this.students = []
  this.numberCredits = numberCredits;
  this.days = days;
  this.timeBlock = timeBlock;
}

Course.prototype.add_student = function(student) {
  student.enroll(this)
}

Course.prototype.conflict = function(otherCourse) {
  var status = false
  for(var i = 0; i < otherCourse.days.length; i++) {
    if(this.days.indexOf(otherCourse.days[i]) === -1) {
      if(otherCourse.timeBlock === this.timeBlock) {
        status = true;
      }
    }
  }
  return status
}

var course = new Course('Javascript', 'CS', 3, ['Tu', 'F'], 1)
var course2 = new Course('Rails', 'CS', 2, ['Tu', 'W'], 1)
var student = new Student('Witwicki', 'Kelly')

course.add_student(student)

console.log(course.add_student(student))
