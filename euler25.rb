#################

## Problems 1 - 25 from the Project Euler website:  https://projecteuler.net/archives
## The wbsite has fuller descriptions of the problems and some of the mathmatical terms used.
## Completed problems are hashed out.  Simply unhash them to run the code.

################


# EULER 1: Find the sum of all multiples of 3 & 5 below 1000
# Answer: 233168
# sum = 0
# (1..999).each do |i|
#   (i%3 == 0 || i%5 == 0) ? sum = sum + i : sum
# end
# puts sum


## EULER 2: Sum the even Fibonacci numbers under 4 million
## Answer: 4,613,732
# x = 1
# y = 2
# z = 0
# sum = z
# until z > 4000000
#   z = x + y
#   (z%2 == 0) ? sum = sum + z : sum
#   x = y
#   y = z
# end

# puts sum + 2


## EULER 3: What is the largest prime factor of 600851475143?
## Answer: 6857
# require 'prime'
# def factors_of(number)
#   number.prime_division.map(&:first)
# end

# puts factors_of(600851475143).pop


## EULER 4: Find the largest palindrome made from the product of two 3-digit numbers.
## Answer: 906609
# largest = 0
# 999.downto(500).each do |num1|
#   num1.downto(500).each do |num2|
#     pal = (num1*num2)
#     (pal > largest && pal.to_s == pal.to_s.reverse) ? largest = pal : largest
#   end
# end

# puts "largest palindrome is: #{largest}"


## EULER 5: What is the smallest positive number that is evenly divisible by 
## all of the numbers from 1 to 20?  This is a logic problem, not a coding problem.
## Answer: 232792560
# x = (2*2*2*2*3*3*5*7)*11*13*17*19  #set in parens gives all other #<20, e.g. 14,18
# puts x


## EULER 6: Find the difference between the sum of the squares of the first 100 integers
## & the square of the sum.
## Answer: 25164150
# sum = 0
# squares = 0
# (1..100).each do |i|
#   sum += i
#   squares += i**2
# end
# puts sum
# puts squares
# puts "the difference is: #{(sum*sum) - squares}"


## EULER 7:  What is the 10 001st prime number? 
## Answer: 104,743
# require 'prime'
# puts Prime.take(10001).pop
## Method before I learned of ".take":
# array = []
# (1..150000).each do |n|
#   n.prime? ? array.push(n) : array
#   array.length > 10000 ? break : next
# end
# puts array.pop


## EULER 8: Find the thirteen adjacent digits in the 1000-digit number that have 
## the greatest product. What is the value of this product?  
## Answer: 23514624000
# string = %Q? 731671765313306249192251196744265747423553491949349698352031277450632623957831801
#              698480186947885184385861560789112949495459501737958331952853208805511125406987471
#              585238630507156932909632952274430435576689664895044524452316173185640309871112172
#              238311362229893423380308135336276614282806444486645238749303589072962904915604407
#              723907138105158593079608667017242712188399879790879227492190169972088809377665727
#              333001053367881220235421809751254540594752243525849077116705560136048395864467063
#              244157221553975369781797784617406495514929086256932197846862248283972241375657056
#              057490261407972968652414535100474821663704844031998900088952434506585412275886668
#              811642717147992444292823086346567481391912316282458617866458359124566529476545682
#              848912883142607690042242190226710556263211111093705442175069416589604080719840385
#              096245544436298123098787992724428490918884580156166097919133875499200524063689912
#              560717606058861164671094050775410022569831552000559357297257163626956188267042825
#              2483600823257530420752963450 ?
# products = []
# (0...1000).each do |x|
#   y= x + 12
#   product = 1
#   (x..y).each do |i|
#     product = product * string[i].to_i
#   end
#   products = products.push(product)
# end
# puts products.max


## EULER 9: There exists exactly one Pythagorean triplet for which a**2 + b**2 = c**2 
## and a + b + c = 1000.  Find the values of a,b,c and their product abc.
## Answer: 31875000
# 997.downto(1).each do |a| 
#   1.upto(a-1).each do |b|
#     c = 1000-a-b
#     if a**2 + b**2 == c**2
#       puts "a = " + a.to_s
#       puts "b = " + b.to_s
#       puts "c = " + c.to_s
#       puts a*b*c
#     else
#       next
#     end
#   end
# end


## EULER 10: Summation of Primes under 2 million
## Answer: 142913828922
# require 'prime'
# puts Prime.take_while {|p| p<2000000}.inject(:+)
## Note: a method for giving all primes in a range
# print Prime.take_while {|x| x <= 100 }.drop_while {|x| x < 50 }
# puts


## EULER 11: Largest product of four consecutive numbers in a 20x20 grid (horizontal, vertical and both diagonal directions)
## The data file is 20grid.txt  To run the code, type 'ruby euler25.rb 20grid.txt'.
## Answer: 70600674

# Find the largest product in a row
def row_product(row)
  largest_prod = 0
  (0..17).each do |x|
    product = row[x].to_i * row[x+1].to_i * row[x+2].to_i * row[x+3].to_i
    product > largest_prod ? largest_prod = product : largest_prod
  end
  largest_prod
end

# Find the largest product among the rows
def and_the_answer_is(input, length)
  answer = 0
  (0..length).each do |i|
    largest = row_product(input[i])
    largest > answer ? answer = largest : answer
  end
  answer
end

# Create the diagonal vectors
def vectors(v)
  diag_vector = []
  (0..16).each do |i|
    vector = []
    (0..19).each do |r|
      c = r+i
      v[r][c].nil? ? vector : vector << v[r][c]      
    end
    diag_vector << vector
  end
  diag_vector
end

eu_answer = []
row = []
grid = []
###  Read the text file into an array ####
lines = File.readlines(ARGV.first)
(0..19).each do |i|
  row = lines[i].split(" ").map(&:to_i)
  grid << row
end

grid_col = grid.transpose
### Left to Right diagonals, u: upper, l: lower ###
l2r_u = vectors(grid)
l2r_l = vectors(grid.transpose)
### Rotate the Array 'grid' to prepare for Right to Left diagonals ###
rotated = []
grid.transpose.each do |x|
  rotated << x.reverse
end
r2l_u = vectors(rotated)
r2l_l = vectors(rotated.transpose)

eu_answer = eu_answer.push(and_the_answer_is(grid, 19))
eu_answer = eu_answer.push(and_the_answer_is(grid_col, 19))
eu_answer = eu_answer.push(and_the_answer_is(l2r_u, 16))
eu_answer = eu_answer.push(and_the_answer_is(l2r_l, 16))
eu_answer = eu_answer.push(and_the_answer_is(r2l_u, 16))
eu_answer = eu_answer.push(and_the_answer_is(r2l_l, 16))

puts "The answer to Problem 11 is: #{eu_answer.sort.pop}"


## EULER 12: What is the value of the first triangle number to have over five hundred divisors?
## A triangle number is the sum of integers, e.g., the seventh such number is 1+2+3+4+5+6+7 = 28.
## Answer: 76576500
# @divisors = []
# sum = 1
# i = 1
# require 'prime'
# def factors_of(number)
#   primes, powers = number.prime_division.transpose
#   exponents = powers.map{|i| (0..i).to_a}
#   @divisors = exponents.shift.product(*exponents).map do |powers|
#     primes.zip(powers).map{|prime, power| prime ** power}.inject(:*)
#   end
#   @divisors
# end

# until @divisors.length > 500
#   i += 1
#   sum += i
#   @divisors = []
#   factors_of(sum)
# end
# puts sum


## EULER 13: Large sum: add 100 50-digit numbers, give first 10 digits of result.
## The source data file is big_sum.txt
## In Terminal run this file with: ruby euler25.rb big_sum.txt
## Answer: 5537376230   
# integer_array = []
# lines = File.readlines(ARGV.first)
# array = lines.collect(&:strip)
# integer_array = array.collect { |x| x.to_i }.inject(:+)

# puts integer_array


## EULER 14: Collartz sequences: Which starting number, under one million, produces the longest chain?
## Answer: 837799, chain length: 524
## Below the 'methods' approach (#2) is 25% faster than using the 'Proc' approach (#1 below).
# require 'benchmark'
# Benchmark.bm do |bm|
#   bm.report("proc:") do
#   halves = Proc.new do |n|
#     n/2
#   end

#   times = Proc.new do |n|
#     3*n + 1
#   end

#   collartz_array = []
#   (77000..1000000).each do |n|
#     x = n
#     array = []
#     while n > 1
#       if n%2 == 0
#         array.push(halves.call(n))
#         n = array.last.to_i
#       else
#         array.push(times.call(n))
#         n = array.last.to_i
#       end
#     end

#     if array.length > collartz_array.last.to_i
#       collartz_array = []
#       collartz_array = collartz_array.push(x)
#       collartz_array = collartz_array.push(array.length)
#     else
#       collartz_array
#     end
#   end
#   puts "#{collartz_array[0]} produces the longest sequence, length: #{collartz_array[1]}"
# end

#   bm.report("methods:") do
#     def halves(n)
#       n/2
#     end

#     def times(n)
#       3*n + 1
#     end
#     collartz_array = []
#     (77000..1000000).each do |n|
#       x = n
#       array = []
#       while n > 1
#         if n%2 == 0
#           array.push(halves(n))
#           n = array.last.to_i
#       else
#         array.push(times(n))
#           n = array.last.to_i
#         end
#       end

#       if array.length > collartz_array.last.to_i
#         collartz_array = []
#         collartz_array = collartz_array.push(x, array.length)
#       else
#         collartz_array
#       end
#     end
#     puts "#{collartz_array[0]} produces the longest sequence, length: #{collartz_array[1]}"
#   end
# end


## EULER 15: Lattice paths: what is the number of paths through a 20x20 lattice?
## Answer: 137846528820

# @fact = 1
# def factorial n
#   if n >= 2
#     @fact = @fact*n
#     factorial(n-1)
#   else
#     @fact
#   end
# end
# x = factorial(40)
# puts x
# @fact = 1
# y = factorial(20)**2
# puts y
# paths = x/y
# puts "The number of paths is #{paths}!"


## EULER 16: Power digit sum --sum the digits of the number: 2**1000
## Answer: 1366
# sum = 0
# b = (2**1000).to_s
# term = b.length-1
# (0..term).each do |i|
#   sum = sum + b[i].to_i
# end

# puts sum

## EULER 17: Number Letter counts - If all the numbers from 1 to 1000 inclusive were 
## written out in words, how many letters would be used?
## Answer ?


## EULER 18: Maximum path sum - Find the maximum sum in a path through a triangle of numbers
## Answer ?


## EULER 19: Counting Sundays - How many Sundays fell on the first of the month during the 
## twentieth century (1 Jan 1901 to 31 Dec 2000)?
## Answer ?

## EULER 20: Sum the digits of 100!
## Answer: 648
# @fact = 1
# sum = 0
# def factorial n
#   if n >= 2
#     @fact = @fact*n
#     factorial(n-1)
#   else
#     @fact
#   end
# end

# x = factorial(100)
# string = x.to_s
# (0...(string.length)).each do |i|
#   sum = sum + string[i].to_i
# end

# puts "The sum of the digits of 100! is #{sum}."

## EULER 21: Amicable numbers - Evaluate the sum of all the amicable numbers under 10000.
## EULER 22: Name scores - What is the total of all the name scores in a file of 5000+ first names?
## EULER 23: Non-abundant sums - Find the sum of all the positive integers which cannot be written
##  as the sum of two abundant numbers.
## EULER 24: Lexicographic permutations - What is the millionth lexicographic permutation
## of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

## EULER 25:  What is the first term in the Fibonacci sequence to contain 1000 digits?
## Answer: 4782
# @i = 3
# def fib (a, b)
#   @i += 1
#   if b.to_s.length < 1000
#     c = b 
#     b = a+b
#     a = c
#     fib(a, b)
#   else
#     #puts b
#     puts "The #{@i}nd term in the Fibonacci sequence contains 1000 digits."
#   end
# end

# fib(2, 3)

######## current end of problem set ############
