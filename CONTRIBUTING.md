# Contributing
 
## Found a Bug?
 
If you find a bug in the source code, you can help us by submitting an issue to our GitHub Repository. Even better, you can submit a Pull Request with a fix.
 
 
## Submit an Issue
 
 
Please fill the following information in each issue you submit:
 
* Title: Use a clear and descriptive title for the issue to identify the problem.
* Description: Description of the issue.
* Steps to Reproduce: numbered step by step. (1,2,3.… and so on)
* Expected behaviour: What you expect to happen.
* Actual behaviour: What actually happens.
* How often reproduces?: what percentage of the time does it reproduce?
* Version: the version of the app.
* Repository: Link to the repository you are working with.
* Operating system: The operating system used.
* Additional information: Any additional to help to reproduce. (screenshots, animated gifs)

# Pull Requests
 
## Description
 Describe the changes in this pull request.
 Explain your rationale of technical decisions you made (unless discussed before).
 ## Links
 Add links to github/jira issues, design documents and other relevant resources (e.g. previous discussions, platform/tool documentation etc.)
 ## Checklist
 - [ ] I have read the [contributing guidelines](../CONTRIBUTING.md).
 - [ ] I wrote/updated tests for new/changed code
 - [ ] I ran all code style checks without errors
 - [ ] I ran all lint checks without errors
 
 # Issue Template
  - Environment
  - Steps to reproduce
  - Expected behavior
  - Actual behavior
  - Checklist
 
## Coding Guidelines
 
* All features or bug fixes **must be tested** by one or more unit tests/specs
* All public API methods **must be documented** in javadoc and potentially in the user guide.
* All Java code must follow [Google's Java Code style](https://google.github.io/styleguide/javaguide.html), the only excption being that annotations on members or classes may be on the same line (no forced line break).
* All ObjectiveC code muste follow the guidelines of the existing code.
 
## Commit messages
 
Each commit message consists of a header, a body and a footer. The header has a special format that includes a type, a scope and a subject:
 
```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```
 
The **header** is mandatory and the **scope** of the header is optional.
 
Any line of the commit message cannot be longer 100 characters! This allows the message to be easier
to read on GitHub as well as in various git tools.
 
Footer should contain a [closing reference to an issue](https://help.github.com/articles/closing-issues-via-commit-messages/) if any.
 
### Revert
 
If the commit reverts a previous commit, it should begin with `revert: `, followed by the header of the reverted commit. In the body it should say: `This reverts commit <hash>.`, where the hash is the SHA of the commit being reverted.
 
### Type
 
Must be one of the following:
 
* **build**: Changes that affect the build system or external dependencies (example scopes: gradle, fastlane, npm)
* **ci**: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
* **docs**: Documentation only changes
* **feat**: A new feature
* **fix**: A bug fix
* **perf**: A code change that improves performance
* **refactor**: A code change that neither fixes a bug nor adds a feature
* **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
* **test**: Adding missing tests or correcting existing tests
 
### Scope
The scope should be the name of the npm package affected (as perceived by person reading changelog generated from commit messages.
 
The following is the list of supported scopes:
 
* **core**
* **plugin**
* **runtime**
* **stubs**
 
 
### Subject
 
The subject contains succinct description of the change:
 
* use the imperative, present tense: "change" not "changed" nor "changes"
* don't capitalize first letter
* no dot (.) at the end
 
 
### Body
 
Just as in the **subject**, use the imperative, present tense: "change" not "changed" nor "changes".
The body should include the motivation for the change and contrast this with previous behavior.
 
### Footer
 
The footer should contain any information about **Breaking Changes** and is also the place to
reference GitHub issues that this commit **Closes**.
 
**Breaking Changes** should start with the word `BREAKING CHANGE:` with a space or two newlines. The rest of the commit message is then used for this.
