package controller.doctor;

import dao.doctor.DoctorDAO;
import model.doctor.DoctorDocument;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ViewDocumentServlet", urlPatterns = {"/ViewDocumentServlet", "/view-document"})
public class ViewDocumentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Document ID is required.");
            return;
        }

        int documentId;
        try {
            documentId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Document ID.");
            return;
        }

        DoctorDAO doctorDAO = new DoctorDAO();
        DoctorDocument doc = doctorDAO.getDoctorDocumentById(documentId);

        if (doc == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Document record not found.");
            return;
        }

        String filePath = doc.getFilePath();
        if (filePath == null || filePath.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "No file path associated with this document record.");
            return;
        }

        String pureFileName = filePath.contains("/") ? filePath.substring(filePath.lastIndexOf('/') + 1) : filePath;
        pureFileName = pureFileName.contains("\\") ? pureFileName.substring(pureFileName.lastIndexOf('\\') + 1) : pureFileName;

        List<File> candidates = new ArrayList<>();

        // 1. Servlet context real path
        String realPath = getServletContext().getRealPath(filePath);
        if (realPath != null) candidates.add(new File(realPath));

        if (filePath.startsWith("/")) {
            String alt = getServletContext().getRealPath(filePath.substring(1));
            if (alt != null) candidates.add(new File(alt));
        }

        String rootPath = getServletContext().getRealPath("/");
        if (rootPath != null) {
            candidates.add(new File(rootPath, filePath));
            candidates.add(new File(rootPath, "uploads/doctors/" + pureFileName));
        }

        // 2. Persistent storage locations
        candidates.add(new File("C:/Online_Medical_Uploads/doctors/" + pureFileName));
        candidates.add(new File(System.getProperty("user.home") + "/.online_medical/uploads/doctors/" + pureFileName));

        // 3. User workspace folder
        String userHome = System.getProperty("user.home");
        candidates.add(new File(userHome + "/OneDrive/Desktop/Online_Medical_System/web/uploads/doctors/" + pureFileName));
        candidates.add(new File(userHome + "/OneDrive/Desktop/Online_Medical_System/build/web/uploads/doctors/" + pureFileName));

        File file = null;
        for (File cand : candidates) {
            if (cand != null && cand.exists() && cand.isFile()) {
                file = cand;
                break;
            }
        }

        if (file != null && file.exists() && file.isFile()) {
            String originalFileName = doc.getFileName() != null ? doc.getFileName() : file.getName();
            String mimeType = getServletContext().getMimeType(originalFileName);
            if (mimeType == null) {
                String lower = originalFileName.toLowerCase();
                if (lower.endsWith(".png")) {
                    mimeType = "image/png";
                } else if (lower.endsWith(".jpg") || lower.endsWith(".jpeg")) {
                    mimeType = "image/jpeg";
                } else if (lower.endsWith(".pdf")) {
                    mimeType = "application/pdf";
                } else if (lower.endsWith(".webp")) {
                    mimeType = "image/webp";
                } else {
                    mimeType = "application/octet-stream";
                }
            }

            response.setContentType(mimeType);
            response.setHeader("Content-Disposition", "inline; filename=\"" + originalFileName + "\"");
            response.setContentLengthLong(file.length());

            try (FileInputStream in = new FileInputStream(file); OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[8192];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                out.flush();
            }
            return;
        }

        // Return 404 so modal knows file is missing
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Physical file not found on disk.");
    }
}
