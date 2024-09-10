package com.foodforward.WebServiceApplication.dao.fileReference;

import com.foodforward.WebServiceApplication.model.databaseSchema.fileReference.file_storage_ref;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.UUID;
@Repository
public interface FileReferenceRepository extends JpaRepository<file_storage_ref, UUID> {


}
