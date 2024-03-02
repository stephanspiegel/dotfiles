#!/usr/bin/env nu

def find-changed-classes [branch:string] {
    ^git diff --name-only --diff-filter=ACMRT $branch | lines | find --regex ".cls$"
}

def is-test-class [class_name:string] {
    open $class_name | into string | str contains @IsTest
}

def is-tested-by-class [class_name:string] {
    open $class_name | into string | str contains "Tested By:" --ignore-case
}

def parse-tested-by [class_name:string] {
    open $class_name | into string | lines 
    | parse --regex '(?i)(?:^[ \t*]*Tested By:\s*)((?:\w+,? *)+)' 
    | get capture0 | split row ',' | str trim
}

def get-test-class-name [project_path:string] {
    $project_path | path basename | split row '.' | get 0 
}

def run-tests [branch:string = "dev-uat"] {

    let changed_classes = find-changed-classes $branch

    let testfiles = $changed_classes 
        | filter { is-tested-by-class $in } 
        | each { parse-tested-by $in } 
        | flatten 
        | flatten


    let testedbyfiles = $changed_classes
        | filter { is-test-class $in } 
        | each {  get-test-class-name $in }

    let sortedClassNames = ($testfiles ++ $testedbyfiles | uniq | sort)

    let classparameters = $sortedClassNames
    | each {|className| '--class-names=' ++ $className}

     let result = do { ^sf apex run test --result-format=json --wait 10 ...$classparameters }
         | from json
         | get result

    {} | insert summary { 
            $result 
            | get summary 
            | select outcome testsRan passing failing skipped passRate failRate 
        } 
        | insert failures { 
            $result
            | get tests 
            | where Outcome == "Fail" 
            | select FullName StackTrace Message 
        }
        | insert classesRun {
            $result
            | get tests.ApexClass.Name
            | uniq
            | sort
        }

}

run-tests
