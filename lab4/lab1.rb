class Student
    attr_reader :name, :gender, :mark
  def initialize(name, gender, mark)
    @name = name
    @gender = gender
    @mark = mark
    print("student #{name} is #{if gender then "male" else "female" end} and has mark #{mark}\n")
  end
end

names = ["andrew","vasil","alex","anastasia"]
genders = [true,true,true,false]
marks = [5,4,3,4]

students = names.zip(genders).zip(marks).map do |x|
   a = x.flatten
   Student.new(a[0],a[1],a[2])
end
students.filter{|s| s.gender && s.mark >=4}.each{|x| print("#{x.name}\n")}
