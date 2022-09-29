from setuptools import setup, find_packages

with open("README.md", "r") as f:
    page_description = f.read()

with open("requirements.txt") as f:
    requirements = f.read().splitlines()

setup(
    name="Pacote_processamento_de_imagens",
    version="0.0.1",
    author="Sergio Eduardo Palmiere",
    author_email="palmiere@hotmail.com",
    description="Pacote de processamento de imagens",
    long_description=page_description,
    long_description_content_type="text/markdown",
    url="https://github.com/SEPalmiere/DIO_Unimed_Ciencia_Dados",
    packages=find_packages(),
    install_requires=requirements,
    python_requires='>=3.8',
)