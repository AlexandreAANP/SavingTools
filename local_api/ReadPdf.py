import base64
from tabula.io import read_pdf
import uuid


class ReadPdf:
    """
    A class for reading tables from a PDF file.

    Args:
        encodedContent (str): The base64 encoded content of the PDF file.

    Attributes:
        pdf_path (str): The path to the saved PDF file.
        tables (pandas.DataFrame): The tables extracted from the PDF file.

    Methods:
        get_tables(): Returns the extracted tables.

    Private Methods:
        __save_pdf(encodedContent): Saves the decoded PDF content to a file.
        __read_pdf_tables(path): Reads the PDF file and extracts the tables.
        __generate_guuid(): Generates a unique identifier using `uuid`.
        __delete_pdf(path): Deletes the saved PDF file.
    """

    def __init__(self, encodedContent):
        self.pdf_path = self.__save_pdf(encodedContent)
        self.tables = self.__read_pdf_tables(self.pdf_path)
        self.__delete_pdf(self.pdf_path)

    def get_tables(self):
        """
        Returns the extracted tables from the PDF file.

        Returns:
            pandas.DataFrame: The extracted tables.
        """
        return self.tables

    def __save_pdf(self, encodedContent):
        """
        Saves the decoded PDF content to a file.

        Args:
            encodedContent (str): The base64 encoded content of the PDF file.

        Returns:
            str: The path to the saved PDF file.
        """
        # Decode the base64 encoded content
        decodedContent = base64.b64decode(encodedContent)

        # generate file name
        file_id = self.__generate_guuid()
        file_name = f"pdf_to_read_{file_id}.pdf"
        # Save the decoded content to a file
        with open(file_name, "wb") as file:
            file.write(decodedContent)
        return file_name

    def __read_pdf_tables(self, path):
        """
        Reads the PDF file and extracts the tables.

        Args:
            path (str): The path to the PDF file.

        Returns:
            pandas.DataFrame: The extracted tables.
        """
        # Read the pdf file
        df = read_pdf(path, pages="all")
        return df

    def __generate_guuid(self):
        """
        Generates a unique identifier using `uuid`.

        Returns:
            str: The generated unique identifier.
        """
        guuid = uuid.uuid4()
        return str(guuid)

    def __delete_pdf(self, path):
        """
        Deletes the saved PDF file.

        Args:
            path (str): The path to the PDF file.
        """
        # Delete the pdf file
        import os

        os.remove(path)
