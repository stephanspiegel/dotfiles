#!/usr/bin/env nu

def find-changed-classes [branch:string] {
    ^git diff --name-only --diff-filter=ACMRT $branch | lines | find .cls
}

def is-test-class [class_name:string] {
    open $class_name 
    | into string 
    | str contains @IsTest
}

def is-tested-by-class [class_name:string] {
    open $class_name 
    | into string 
    | str contains "Tested By:"
}

def parse-tested-by [class_name:string] {
    open $class_name 
    | into string 
    | lines 
    | parse --regex '(?:^[ \t*]*Tested By:\s*)((?:\w+,? *)+)' 
    | get capture0 
    | split words
}

def get-test-class-name [project_path:string] {
    $project_path 
    | path basename 
    | split words 
    | get 0 
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
    print $sortedClassNames

}

run-tests
