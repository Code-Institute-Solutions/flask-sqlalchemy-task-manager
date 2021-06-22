FROM gitpod/workspace-postgres

USER root
# Setup Heroku CLI
RUN curl https://cli-assets.heroku.com/install.sh | sh

# Setup Python linters
RUN pip3 install flake8 flake8-flask flake8-django

USER gitpod

# Upgrade Node

ENV NODE_VERSION=14.15.4
RUN bash -c ". .nvm/nvm.sh && \
        nvm install ${NODE_VERSION} && \
        nvm alias default ${NODE_VERSION} && \
        npm install -g yarn"

RUN echo 'alias heroku_config=". $GITPOD_REPO_ROOT/.vscode/heroku_config.sh"' >> ~/.bashrc
RUN echo 'alias run="python3 $GITPOD_REPO_ROOT/manage.py runserver 0.0.0.0:8000"' >> ~/.bashrc
RUN echo 'alias python=python3' >> ~/.bashrc	
RUN echo 'alias pip=pip3' >> ~/.bashrc	
RUN echo 'alias font_fix="python3 $GITPOD_REPO_ROOT/.vscode/font_fix.py"' >> ~/.bashrc
ENV PATH=/home/gitpod/.nvm/versions/node/v${NODE_VERSION}/bin:$PATH

# Local environment variables

ENV PORT="8080"
ENV IP="0.0.0.0"

USER root
# Switch back to root to allow IDE to load
