# Description

> Please write a summary of what changes/additions this code provides.

## Closes issue(s)

> Remove this section if irrelevant. 

Include links to the issue(s) on GitHub or Jira (eg: https://github.com/datirium/workflows/issues/XYZ)


## Type of change

> Please delete options that are not relevant.

- [ ] **Tool** Bug fix (non-breaking change which fixes an issue)
- [ ] **Workflow** Bug fix (non-breaking change which fixes an issue)
- [ ] New feature for **tool** (non-breaking change which adds functionality)
- [ ] New feature for **workflow** (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] This change requires a documentation update

## Testing Steps

> Please describe testing steps here to confirm functionaly of code. Maintainers or another developer should easily be able to follow these steps to test functionality.
> Testing steps should include screen shots of desired and achieved capabilities within SciDAP

Ex:
1. Able to succesfully create and run a sample using new/modified workflow [link to relevant screenshots]()
2. Finished sample displays desired visualPlugins appropriately [link to relevant screenshot]()
3. Able to integrate workflow as up/down stream for another sample (TODO: establish what workflows are required to have up/down stream compatability with other workflows)

> if testing is moved to github actions, this section may (instead) involve steps/tutorial_links for updating tests/data for the repo

## Screenshot

> Delete this section if irrelevant. 

## Manual VersionControl Settings

> This Section has yet to be conceptually structure
> However, the core idea is to allow BI's to manually set what kind of version update is occuring on effect tools/workflows in their PR

ideally, this will require either: 
- back and forth from PR to git-hooks (so that it's auto decision is known by PR authors and can be overturned)
- or, a setting that if ANY manual versionings are set, none given versionings will default to the OTHER mode
    - > Ex: if workflow A, B, C are editted, and BI says workflow A is a PATCH update, then git-hooks will auto make B and C "major" updates
- or, a "select-one" option for
    - [option1] make all changes MAJOR 
    - [option2] make all changes PATCH
    - [option3] manaully choose (requires more conceptual structure on scidaps end) 
        - ? list all patches and others are major? 
        - vice-versa?
        - ? list all major/patches and others are automatically determined?
    - if none of the above are selected, our git-hooks will do their automatic checks to determine major vs patch updates
 
## Checklist

- [ ] I have self-reviewed my own code
- [ ] I have made corresponding changes to the documentation tags on modified workflows
- [ ] I have added tests and created no new failing tests
