def squashuat [branch:string = (^git branch --show-current)]{
    let promotionbranch = "promotion/" + $branch
	^git fetch
	^git stash
	^git switch $promotionbranch
	^git pull
	^git switch dev-uat
	^git pull
	^git merge --squash $promotionbranch
	^git commit -m "Merge " + $promotionbranch +  " into uat"
	^git push
	^git push origin --delete $promotionbranch
	^git stash pop
    start 'https://jenkins.infra.perch-labs.net/job/Community%20Solar%20Engineering/job/SMP/job/dev-uat/'

}
