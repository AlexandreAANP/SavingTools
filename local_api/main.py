from flask import Flask
from Auth import basic_auth_required
from ReadPdf import ReadPdf
import base64

app = Flask(__name__)


@app.route("/")
def ping():
    return "", 200


@app.route("/pdf/get_data/")
@basic_auth_required()
def get_pdf_data():
    """
    Retrieves data in tables from a PDF file and returns it as a JSON response.

    Returns:
        A JSON response containing the extracted tables from the PDF file.
        In the format of an DataFrame from pandas lib. 
    """
    with open("local_api/CTT_extract_example.pdf", "rb") as file:
        content = file.read()

    encodedContent = base64.b64encode(content)
    tables = []

    Tables = ReadPdf(encodedContent).get_tables()
    for table in Tables:
        tables.append(table.to_dict())

    return {"tables": tables}, 200


app.run(port=8989, debug=False)
