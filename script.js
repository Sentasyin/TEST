// Function to load and search the XML file and XSL file, and apply the transformation
function loadXML(callback) {
    $.ajax({
        type: "GET",
        url: "coin_data.xml", // The path to your XML file
        dataType: "xml",
        success: function (xml) {
            callback(xml);
        }
    });
}

// Function to apply XSL transformation
function applyXSLT(xml, callback) {
    $.ajax({
        type: "GET",
        url: "style.xsl", // The path to your XSL file
        dataType: "xml",
        success: function (xsl) {
            if (window.ActiveXObject || "ActiveXObject" in window) { // For IE
                const ex = xml.transformNode(xsl);
                callback(ex);
            } else if (document.implementation && document.implementation.createDocument) { // For modern browsers
                const xsltProcessor = new XSLTProcessor();
                xsltProcessor.importStylesheet(xsl);
                const resultDocument = xsltProcessor.transformToFragment(xml, document);
                callback(resultDocument);
            }
        }
    });
}

// Function to display the transformed XML content
function displayXML(xmlContent) {
    const result = $("#result");
    result.empty(); // Clear previous results
    result.append(xmlContent);
}

// Function to search XML content
function searchXML() {
    const searchText = $("#searchInput").val().toLowerCase();
    
    loadXML(function (xml) {
        // Perform search using XPath
        let found = false;
        
        // Search specific elements such as title, authority, inscriptions
        $(xml).find("title, authority, inscriptions").each(function () {
            const textContent = $(this).text().toLowerCase();
            if (textContent.includes(searchText)) {
                found = true;
                applyXSLT(xml, displayXML);
            }
        });
        
        if (!found) {
            $("#result").html("<p>No results found.</p>");
        }
    });
}

// Load the XML file and apply XSL transformation on page load
$(document).ready(function () {
    loadXML(function (xml) {
        applyXSLT(xml, displayXML);
    });
});
