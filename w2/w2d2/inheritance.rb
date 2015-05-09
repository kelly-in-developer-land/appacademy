class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end

end

class Manager < Employee

  attr_reader :employees

  def initialize(name, title, salary, boss, employees = [])
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @employees = employees
  end

  def add_employee(person)
    @employees << person
  end
  def bonus(multiplier)
    total_salary = 0
    employee_queue = [self]

    until employee_queue.empty?
      current_employee = employee_queue.shift
      if current_employee.class == Manager
        current_employee.employees.each do |employee|
          employee_queue << employee
        end
      end
      total_salary += current_employee.salary
    end
    total_salary -= @salary
    total_salary * multiplier
  end

end

Ned = Manager.new("Ned", "Founder", 1000000, nil)
Darren = Manager.new("Darren", "TA manager", 78000, Ned)
Shawna = Employee.new("Shawna", "TA", 12000, Darren)
David = Employee.new("David", "TA", 10000, Darren)
Ned.add_employee(Darren)
Darren.add_employee(Shawna)
Darren.add_employee(David)
puts Ned.bonus(5)
puts Darren.bonus(4)
puts David.bonus(3)
