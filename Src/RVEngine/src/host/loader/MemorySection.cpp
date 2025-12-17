#include "loader.hpp"

#if _WIN32 || _WIN64
#include <Psapi.h>
#include <DbgHelp.h>
#endif  // _WIN32 || _WIN64


#include "MemorySection.hpp"

#if _WIN32 || _WIN64
MemorySections::MemorySections() {
    MODULEINFO modInfo = {nullptr};
    HMODULE hModule = GetModuleHandleA(nullptr);
    GetModuleInformation(GetCurrentProcess(), hModule, &modInfo, sizeof(MODULEINFO));
    const uintptr_t baseAddress = reinterpret_cast<uintptr_t>(modInfo.lpBaseOfDll);
    const uintptr_t moduleSize = static_cast<uintptr_t>(modInfo.SizeOfImage);
    //sections.push_back(MemorySection(modInfo));

    auto dosHdr = (PIMAGE_DOS_HEADER)baseAddress;
    auto NtHeader = (PIMAGE_NT_HEADERS)(baseAddress + dosHdr->e_lfanew);
    WORD NumSections = NtHeader->FileHeader.NumberOfSections;
    PIMAGE_SECTION_HEADER Section = IMAGE_FIRST_SECTION(NtHeader);
    for (WORD i = 0; i < NumSections; i++)
    {

        MemorySection sec(baseAddress + Section->VirtualAddress, baseAddress + Section->VirtualAddress + Section->SizeOfRawData);
        if (Section->Characteristics & IMAGE_SCN_MEM_READ)
            sec.access = MemorySection::SectionAccess(sec.access | MemorySection::SectionAccess::R);
        if (Section->Characteristics & IMAGE_SCN_MEM_WRITE)
            sec.access = MemorySection::SectionAccess(sec.access | MemorySection::SectionAccess::W);
        if (Section->Characteristics & IMAGE_SCN_MEM_EXECUTE)
            sec.access = MemorySection::SectionAccess(sec.access | MemorySection::SectionAccess::X);

        sections.emplace_back(sec);

        printf("%-8s\t%x\t%x\t%x\n", Section->Name, Section->VirtualAddress,
               Section->PointerToRawData, Section->SizeOfRawData);
        Section++;
    }
}
#endif  // _WIN32 || _WIN64
