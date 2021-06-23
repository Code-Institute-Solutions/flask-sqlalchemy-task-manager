# 12 - Deploying Our Project to Heroku

---

### Check which Python packages are currently installed in our workspace
- `pip3 list`

### Freeze the current Python packages into a `requirements.txt` file
- `pip3 freeze --local > requirements.txt`

### Create the `Procfile` required for Heroku
- `echo web: python run.py > Procfile`

### Heroku: Postgres Add-On
- From the **Resources** tab on Heroku, search for `heroku postgres` within the **Add-Ons** section.
- Select the `Hobby Dev - Free` option, and submit.
- From the **Settings** tab on Heroku, and click "Reveal Conig Vars"
- Add the remaining environment variables hidden within our `env.py` to the Heroku config vars:
    - `DATABASE_URL`: comes with the **postgres add-on** above
    - `IP`: `0.0.0.0`
    - `PORT`: `5000`
    - `SECRET_KEY`: `any_secret_key`
    - `DEBUG`: `True` (*only during development*)
    - ~~`DEVELOPMENT`~~: **DO NOT INCLUDE ON HEROKU**
    - ~~`DB_URL`~~: **DO NOT INCLUDE ON HEROKU**
- From the **Deploy** tab on Heroku, these next steps are for Automatic Deploys using GitHub:
    - Select **GitHub** for the deployment method.
    - Ensure your GitHub profile name is listed, and then input your repository name.
    - Once Heroku sees your repository, click "Connect".
    - Select the appropriate branch to deploy from (usually `main` or `master`).
    - Click "Enable Automatic Deploys".
    - Click "Deploy Branch". (*can take a few minutes to build*)
- Once the app successfully builds, go back to the **Settings** tab.
- Click "Reveal Config Vars".
- If the `DATABASE_URL` starts with `postgres://` instead of `postgresql://`, then follow these steps:
    - Open the `__init__.py` file.
    - `import re` at the top.
    - Within the `else:` statement, replace the code with the following:
        - ```python
          else:
              uri = os.environ.get("DATABASE_URL")
              if uri.startswith("postgres://"):
                  uri = uri.replace("postgres://", "postgresql://", 1)
              app.config["SQLALCHEMY_DATABASE_URI"] = uri
          ```
    - Commit all changes to GitHub.
- From the **Activity** tab on Heroku, make sure the build completes with those changes.
- Click the **More** dropdown in the top-right corner of Heroku.
- Select "Run Console", and follow these steps in the console:
    - `python3`
    - `from taskmanager import db`
    - `db.create_all()`
    - `exit()`
- Everything should be connected and working now, so click the **Open App** button.
