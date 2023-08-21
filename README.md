# README

![dektop](screenshot.png)

## GPG key

### Export

    gpg --armor --export-secret-keys <email> > private.key
	gpg --symmetric private.key

### Account recovery

Recover gpg key

	gpg -d key.gpg

Import gpg private key

	gpg --import pgp-private-keys.asc

Clone the password-store.

	git clone https://gitlab.com/joajfreitas/pass
