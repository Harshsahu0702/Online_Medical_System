package controller.doctor;

import dao.doctor.DoctorDAO;
import model.doctor.DoctorDocument;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(name = "DoctorDocumentUploadServlet", urlPatterns = {"/DoctorDocumentUploadServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class DoctorDocumentUploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("doctorId") == null) {
            response.sendRedirect(request.getContextPath() + "/DoctorLoginServlet");
            return;
        }

        int doctorId = (Integer) session.getAttribute("doctorId");
        String documentType = request.getParameter("documentType");

        if (documentType == null || documentType.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/DoctorProfileServlet?doc_error=missing_type");
            return;
        }

        Part filePart = request.getPart("documentFile");
        if (filePart == null || filePart.getSize() == 0) {
            response.sendRedirect(request.getContextPath() + "/DoctorProfileServlet?doc_error=no_file");
            return;
        }

        String originalFileName = extractFileName(filePart);
        if (originalFileName == null || originalFileName.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/DoctorProfileServlet?doc_error=invalid_file");
            return;
        }

        String extension = "";
        int dotIndex = originalFileName.lastIndexOf(".");
        if (dotIndex != -1) {
            extension = originalFileName.substring(dotIndex).toLowerCase();
        }

        if (!extension.equals(".pdf") && !extension.equals(".jpg") && !extension.equals(".jpeg") && !extension.equals(".png")) {
            response.sendRedirect(request.getContextPath() + "/DoctorProfileServlet?doc_error=file_type");
            return;
        }

        String uploadPath = getServletContext().getRealPath("/uploads/doctors");
        File uploadDirectory = new File(uploadPath);
        if (!uploadDirectory.exists()) {
            uploadDirectory.mkdirs();
        }

        String newFileName = UUID.randomUUID().toString() + extension;
        File savedFile = new File(uploadDirectory, newFileName);
        filePart.write(savedFile.getAbsolutePath());

        // Also backup to persistent storage locations
        try {
            File persistentDir1 = new File("C:/Online_Medical_Uploads/doctors");
            if (!persistentDir1.exists()) persistentDir1.mkdirs();
            java.nio.file.Files.copy(savedFile.toPath(), new File(persistentDir1, newFileName).toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);

            String userHome = System.getProperty("user.home");
            File persistentDir2 = new File(userHome + "/OneDrive/Desktop/Online_Medical_System/web/uploads/doctors");
            if (persistentDir2.exists()) {
                java.nio.file.Files.copy(savedFile.toPath(), new File(persistentDir2, newFileName).toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
            }
        } catch (Exception ignored) {}

        DoctorDocument doc = new DoctorDocument();
        doc.setDoctorId(doctorId);
        doc.setDocumentType(documentType);
        doc.setFileName(originalFileName);
        doc.setFilePath("/uploads/doctors/" + newFileName);
        doc.setVerificationStatus("PENDING");

        DoctorDAO doctorDAO = new DoctorDAO();
        boolean success = doctorDAO.saveOrUpdateDoctorDocument(doc);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/DoctorProfileServlet?doc_success=1");
        } else {
            response.sendRedirect(request.getContextPath() + "/DoctorProfileServlet?doc_error=db_error");
        }
    }

    private String extractFileName(Part part) {
        String content = part.getHeader("content-disposition");
        if (content == null) {
            return null;
        }
        for (String item : content.split(";")) {
            if (item.trim().startsWith("filename")) {
                String fileName = item.substring(item.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1);
            }
        }
        return null;
    }
}
