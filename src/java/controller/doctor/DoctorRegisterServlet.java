package controller.doctor;

import dao.doctor.DoctorDAO;
import model.doctor.Doctor;
import model.doctor.DoctorDocument;
import model.doctor.Specialization;
import model.doctor.Clinic;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)
public class DoctorRegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            DoctorDAO doctorDAO = new DoctorDAO();

            // Get all specializations
            List<Specialization> specializations =
                    doctorDAO.getAllSpecializations();

            // Get all clinics
            List<Clinic> clinics =
                    doctorDAO.getAllClinics();

            // Send data to JSP
            request.setAttribute(
                    "specializations",
                    specializations
            );

            request.setAttribute(
                    "clinics",
                    clinics
            );

            // Open registration page
            request.getRequestDispatcher(
                    "/doctor/register.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load doctor registration page."
            );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        
        // 1. GET FORM DATA

        String name =request.getParameter("name");

        String email =request.getParameter("email");

        String phone =request.getParameter("phone");
        String specializationIdStr =request.getParameter("specializationId");
        String clinicIdStr =request.getParameter("clinicId");
        String qualification =request.getParameter("qualification");
        String experienceStr =request.getParameter("experience");
        String licenseNumber =request.getParameter("licenseNumber");
        String consultationFeeStr =request.getParameter("consultationFee");
        String registrationAuthority =request.getParameter("registrationAuthority");
        String bio =request.getParameter("bio");
        String consultationType =request.getParameter("consultationType");
        String password =request.getParameter("password");
        String confirmPassword =request.getParameter("confirmPassword");
        // 2. PASSWORD CHECK
        if (password == null ||
            confirmPassword == null ||
            !password.equals(confirmPassword)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/DoctorRegisterServlet?error=password"
            );
            return;
        }
        // 3. CONVERT NUMERIC VALUES

        int specializationId;
        int experience;
        double consultationFee;
        Integer clinicId = null;
        try 
        {
            specializationId =Integer.parseInt(specializationIdStr);
            experience =Integer.parseInt(experienceStr);
            consultationFee =Double.parseDouble(consultationFeeStr);

            if (clinicIdStr != null &&
                !clinicIdStr.trim().isEmpty() &&
                !clinicIdStr.equals("0")) {

                clinicId =Integer.parseInt(clinicIdStr);
            }

        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/DoctorRegisterServlet?error=number"
            );

            return;
        }
        // 4. CREATE DOCTOR MODEL
        Doctor doctor =new Doctor();
        
        doctor.setName(name);
        doctor.setEmail(email);
        doctor.setPhone(phone);
        doctor.setSpecializationId(specializationId);
        doctor.setClinicId(clinicId);
        doctor.setQualification(qualification);
        doctor.setExperience(experience);
        doctor.setLicenseNumber(licenseNumber);
        doctor.setConsultationFee(consultationFee);
        doctor.setRegistrationAuthority(registrationAuthority);
        doctor.setBio(bio);
        doctor.setConsultationType(consultationType);
        doctor.setPassword(password);

        // 5. DOCUMENT UPLOAD DIRECTORY
        String uploadPath =
                getServletContext().getRealPath(
                        "/uploads/doctors"
                );
        File uploadDirectory =new File(uploadPath);
        if (!uploadDirectory.exists()) {
            uploadDirectory.mkdirs();
        }

        // 6. DOCUMENT LIST
        List<DoctorDocument> documents =
                new ArrayList<DoctorDocument>();
        try 
        {
            // Medical Registration Certificate
            Part registrationPart =
                    request.getPart(
                            "registrationCertificate"
                    );


            DoctorDocument registrationDocument =
                    saveDocument(
                            registrationPart,
                            "MEDICAL_REGISTRATION",
                            uploadDirectory
                    );


            if (registrationDocument == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/DoctorRegisterServlet?error=documents"
                );

                return;
            }


            documents.add(
                    registrationDocument
            );

            // MBBS Certificate
            Part mbbsPart =
                    request.getPart(
                            "mbbsCertificate"
                    );


            DoctorDocument mbbsDocument =
                    saveDocument(
                            mbbsPart,
                            "MBBS_DEGREE",
                            uploadDirectory
                    );


            if (mbbsDocument == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/DoctorRegisterServlet?error=documents"
                );

                return;
            }


            documents.add(
                    mbbsDocument
            );
            // Identity Proof
            Part identityPart =
                    request.getPart(
                            "identityProof"
                    );


            DoctorDocument identityDocument =
                    saveDocument(
                            identityPart,
                            "IDENTITY_PROOF",
                            uploadDirectory
                    );


            if (identityDocument == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/DoctorRegisterServlet?error=documents"
                );

                return;
            }


            documents.add(
                    identityDocument
            );
         // Additional Qualification
           
            Part additionalPart =
                    request.getPart(
                            "additionalQualification"
                    );


            if (additionalPart != null &&
                additionalPart.getSize() > 0) {

                DoctorDocument additionalDocument =
                        saveDocument(
                                additionalPart,
                                "ADDITIONAL_QUALIFICATION",
                                uploadDirectory
                        );


                if (additionalDocument != null) {

                    documents.add(
                            additionalDocument
                    );
                }
            }


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/DoctorRegisterServlet?error=documents"
            );

            return;
        }

        // 7. DAO
        DoctorDAO doctorDAO =new DoctorDAO();
        boolean result =doctorDAO.registerDoctor(doctor,documents);
        // 8. RESULT
        if (result) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/DoctorRegisterServlet?success=1"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/DoctorRegisterServlet?error=1"
            );
        }
    }

    // SAVE DOCUMENT

    private DoctorDocument saveDocument(
            Part part,
            String documentType,
            File uploadDirectory)
            throws IOException {


        // No file
        if (part == null ||
            part.getSize() == 0) {

            return null;
        }

        // MAX SIZE = 5 MB

        if (part.getSize() > 5 * 1024 * 1024) {

            return null;
        }

        // ORIGINAL FILE NAME
        String originalFileName =
                getFileName(part);


        if (originalFileName == null ||
            originalFileName.trim().isEmpty()) {

            return null;
        }
        // FILE EXTENSION
        String extension = "";

        int dotIndex =
                originalFileName.lastIndexOf(".");


        if (dotIndex != -1) {

            extension =
                    originalFileName
                    .substring(dotIndex)
                    .toLowerCase();
        }
        // ALLOWED TYPES
        if (!extension.equals(".pdf") &&
            !extension.equals(".jpg") &&
            !extension.equals(".jpeg") &&
            !extension.equals(".png")) {

            return null;
        }
        // UNIQUE FILE NAME
        String newFileName =
                UUID.randomUUID().toString()
                + extension;
        // CREATE FILE
        File savedFile =
                new File(
                        uploadDirectory,
                        newFileName
                );
        // SAVE FILE
        part.write(
                savedFile.getAbsolutePath()
        );
        // CREATE DOCUMENT MODEL
        DoctorDocument document =
                new DoctorDocument();

        document.setDocumentType(
                documentType
        );

        document.setFileName(
                originalFileName
        );

        document.setFilePath(
                "/uploads/doctors/"
                + newFileName
        );

        document.setVerificationStatus(
                "PENDING"
        );


        return document;
    }
    // GET ORIGINAL FILE NAME
    private String getFileName(Part part) {

        String content =
                part.getHeader(
                        "content-disposition"
                );


        if (content == null) {

            return null;
        }


        String[] items =
                content.split(";");


        for (String item : items) {

            item = item.trim();


            if (item.startsWith("filename")) {

                String fileName =
                        item.substring(
                                item.indexOf('=') + 1
                        ).trim();


                fileName =
                        fileName.replace(
                                "\"",
                                ""
                        );


                int lastSlash =
                        Math.max(
                                fileName.lastIndexOf('/'),
                                fileName.lastIndexOf('\\')
                        );


                if (lastSlash >= 0) {

                    fileName =
                            fileName.substring(
                                    lastSlash + 1
                            );
                }


                return fileName;
            }
        }


        return null;
    }
}