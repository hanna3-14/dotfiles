# how to sign your git commits
- `gpg --full-generate-key` **use the correct email address**
- `gpg --export --armor <email>` add public gpg key to GitHub
- `gpg --list-secret-keys --keyid-format=long` add id to gitconfig

## gitconfig
```
[user]
	signingkey = id (or email address)
[commit]
	gpgsign = true
[tag]
	gpgsign = true
```
